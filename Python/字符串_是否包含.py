s = "This be a string"


if "is" in s:
    print('Found ' is ' in the string.')


if s.find("is") == -1:
    print("No 'is' here!")
else:
    print("Found 'is' in the string.")
