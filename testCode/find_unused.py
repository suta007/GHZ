import re

path = r"d:\LuaCode\ghz\src\demo_opt.luau"
with open(path, "r", encoding="utf-8") as f:
    text = f.read()

# Let's find all local variable declarations at the top of the file
local_vars = re.findall(r'^local\s+([a-zA-Z0-9_]+)\s*=', text, flags=re.MULTILINE)

# Now let's count occurrences of each variable in the script
unused = []
for var in local_vars:
    # A variable might be declared and then never used again.
    # We count how many times it appears as a whole word.
    pattern = r'\b' + re.escape(var) + r'\b'
    matches = re.findall(pattern, text)
    # If the count is 1, it's only the declaration itself!
    if len(matches) == 1:
        unused.append(var)

print("Unused Local Variables Found:")
for u in unused:
    print("- " + u)
