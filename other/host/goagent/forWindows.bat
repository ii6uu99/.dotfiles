::google host update shell for Windows

::ԭ��: ��github������google host��Ȼ��д��C:\Windows\System32\drivers\etc\hosts�У���������Žű������� �Լ�ʵ���������

::windowsû���Դ��Ľű����ߣ�������Ҫ�Ȱ�װgit bash��װ����Щ����
::git bash ���ص�ַ https://git-scm.com/download ѡ��汾 ��װ
::֮��git��װĿ¼�µ�usr\bin�ļ�����ӵ����������е�path���ԣ������аٶ������ӻ�������

::�ڸýű����Ҽ����Թ���Ա������м���

curl -O https://raw.githubusercontent.com/racaljk/hosts/master/hosts

cat hosts > C:\Windows\System32\drivers\etc\hosts

rm hosts

echo '�����ʾcurl��cat�������Ҳ����������Ķ��ýű�������ע�Ͳ��֣�������������'

pause

