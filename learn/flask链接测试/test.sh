sleep 5
if curl web:5000 | grep -q '<b>Visits:</b> '; then
    echo "Tests passed"
    exit 0
else
    echo "Tests failed"
    exit 1
fi    
