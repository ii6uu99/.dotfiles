#! /usr/bin/env python
#TODO:
# check Makefile's coding rules
# check trivial indentation (spaces/tabulations)
# check #ifndef MY_HEADER_H_ etc.
# check Makefile relink
# add a autorized functions file
# add some command line arguments

import sys
import os
import re

score = 0
curr_file = ''
curr_line = 0
in_func_param = False
func_param_number = 0
func_count = 0
func_line_count = 0

MAX_LEN = 80
MAX_PARAM_NUMBER = 4
MAX_LINES_FUNC = 25
MAX_FUNCS = 5
MAX_PARAM = 4

# utilities ---------------------

def emit_err(msg, malus = 1):
    print('{0}:{1}:\t{2} (-{3} pt(s))'.format(curr_file, curr_line, msg, malus))
    global score
    score -= malus

def regex_test(string, regex):
    p = re.compile('.*' + regex + '.*')
    return p.match(string)

def check_len(line):
    balen = len(line)

    if balen > MAX_LEN:
        emit_err("line too long", balen - MAX_LEN)

# pure test functions -----------

def check_keyword_paren(line):
    keywords = ['if', 'while']

    for word in keywords:
        if regex_test(line, '{}\('.format(word)):
            emit_err('missing space after `{}\' keyword'.format(word))

    if line.find('return') < 0:
        return 0
    if regex_test(line, 'return[^ ]'):
        emit_err('missing space after "return"')
        return 1
    if line.find('return ;') >= 0:
        return 0
    if regex_test(line, 'return \(.*\);') is None:
        emit_err('content of return not enclosed within parentheses')

def c_specifics(line):
    if regex_test(line, '^#[ \t]*define'):
        emit_err('defines aren\'t really allowed within a C file')

def check_trailing(line):
    count = 1

    if len(line) == 0:
        return
    while count <= len(line) and line[-count] == ' ':
        count += 1
    if count > 1:
        emit_err("trailing space(s)", count - 1)

def check_func(line):
    global in_func_param
    global func_line_count
    global func_param_number
    global func_count
    global MAX_PARAM

    if in_func_param:
        if regex_test(line, '{'):
            in_func_param = False
            func_line_count += 1
            if func_param_number > MAX_PARAM:
                emit_err("too many parameters", func_param_number - MAX_PARAM)
            func_param_number = 1
    if func_line_count == 0:
        if regex_test(line, '^.*\(.*\)$'):
            func_line_count += 1
        elif regex_test(line, '^.*\('):
            in_func_param = True
            func_line_count += 1
        if func_line_count == 1 or in_func_param == True:
            if regex_test(line, '[\t]+.*\(') is None and regex_test(line, '#define') is None:
                emit_err("missing tabulation(s) before function's name")

    # are we going out ?
    if func_line_count > 0 and regex_test(line, '^}'):
        # -3 because we count the brackets and the function's name
        if func_line_count - 3 > MAX_LINES_FUNC:
            emit_err('function is is more than {} lines'.format(MAX_LINES_FUNC), (func_line_count - 3) - MAX_LINES_FUNC)
        func_line_count = 0
        #add one function to count
        func_count += 1
        return 0
    if func_line_count > 0 and in_func_param == False:
        func_line_count += 1


def check_comments(line):
    global is_in_comment
    global func_line_count

    if regex_test(line, '//'):
        emit_err('invalid C++ like comment')
    if  func_line_count > 0 and regex_test(line, '/\*'):
        emit_err('comments are not allowed within functions')
    if regex_test(line, '^#endif') == False:
        if regex_test(line, '^.+/\*'):
            emit_err('invalid comment (check characters before "/*")')
        if regex_test(line, '^/\*.+'):
            emit_err('invalid comment (check trailing characters)')
        if regex_test(line, '^.+\*/'):
            emit_err('invalid comment (check characters before "*/")')
        if regex_test(line, '^\*/.+'):
            emit_err('invalid comment (check trailing characters)')

    if regex_test(line, '^/\*'):
        is_in_comment = True
        if regex_test(line, '\*/'):
            is_in_comment = False
        return 0
    if regex_test(line, '\*/'):
        is_in_comment = False
    if is_in_comment == True:
        if regex_test(line, '^\*\*') is None:
            emit_err("invalid comment")

def err_header(counter):
    emit_err("invalid or missing header", 42)
    return counter

def header_generic(file, f, c1, c2, c3):
    counter = 1
    line = f.readline()
    if line != c1 + '\n':
        return err_header(counter)
    while line and counter < 8:
        line = f.readline()
        if line.startswith(c2) is False:
            return err_header(counter)
        counter += 1
    if counter != 8:
        return err_header(counter)
    counter += 1
    if f.readline() != c3 + '\n':
        return err_header(counter)
    return counter

def check_header(file, f):
    if file.endswith('.c') or file.endswith('.h'):
        return header_generic(file, f, '/*', '**', '*/')
    elif file == 'Makefile':
        return header_generic(file, f, '#', '#', '#')
    return 0

def check_prototype(line):
    global func_line_count

    if func_line_count == 0 and regex_test(line, '^.+\(.*\);[ \t]*$'):
        emit_err("prototypes are only allowed within header files");

def check_filename(file):

    if regex_test(file, '^(Makefile|(.*\.[ch]))$') is None:
        sys.stderr.write('error: unsupported file `{}\'\n'.format(file))
        return
    if regex_test(file, '^Makefile|([0-9_a-z.])+$') is None:
        emit_err("invalid file name `{}\'. -> [0-9_a-z]".format(file))

def check_macro(line):

    if regex_test(line, '#define'):
        if regex_test(line, '#define[ \t]+[A-Z0-9_]+(\(.*\))?([ \t]|$)') is None:
            emit_err('macro name must be uppercase letters and underscores only')


# File input ------------------------------------------

def check_file(file):
    global curr_file
    global curr_line
    global in_func_param
    global func_count
    global func_line_count
    global func_param_number
    global is_in_comment

    curr_file = file
    curr_line = 0
    in_funcs_params = False
    func_count = 0
    func_line_count = 0
    func_param_number = 0
    is_in_comment = False

    with open(file) as f:
        curr_line += check_header(file, f)
        line = f.readline()
        check_filename(os.path.basename(file))
        while line:
            line = line.replace('\n', '')
            curr_line += 1
            check_len(line)
            check_trailing(line)
            check_comments(line)
            check_macro(line)
            if file.endswith('.c'):
                c_specifics(line)
                check_func(line)
                check_keyword_paren(line)
                check_prototype(line)
            line = f.readline()
    if func_count > MAX_FUNCS:
        emit_err('there is {} functions in this file (max: {})'.format(func_count, MAX_FUNCS), func_count - MAX_FUNCS)

if __name__ == '__main__':

    for file in sys.argv[1:]:
        check_file(file)
    print('note finale : {}'.format(score))
