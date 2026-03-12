import re

path = r"d:\LuaCode\ghz\src\demo_opt.luau"
with open(path, "r", encoding="utf-8") as f:
    text = f.read()

# We need to manually fix actionQueue inserts for ProcessRemove because my last script wasn't safe
text = text.replace(
    "if table.find(action.args or {}, true) and action.FuncName == ProcessRemove then inQueueRemoveCrops = true end",
    "if type(action.args) == 'table' and action.args[1] == true and action.FuncName == ProcessRemove then inQueueRemoveCrops = true end"
)
text = text.replace(
    "if table.find(action.args or {}, false) and action.FuncName == ProcessRemove then inQueueRemovePlants = true end",
    "if type(action.args) == 'table' and action.args[1] == false and action.FuncName == ProcessRemove then inQueueRemovePlants = true end"
)


# In demo_opt.luau, around line 2000
new_queue = """		if Options.tgRemoveFruitEnable.Value and not inQueueRemoveCrops and not isRemoveCrops then 
			table.insert(actionQueue, { FuncName = ProcessRemove, args = {true} }) 
		end
		if Options.tgRemovePlantsEnable.Value and not inQueueRemovePlants and not isRemovePlants then 
			table.insert(actionQueue, { FuncName = ProcessRemove, args = {false} }) 
		end"""

pattern = r'if Options.tgRemoveFruitEnable.Value and not inQueueRemoveCrops and not isRemoveCrops then.*?end'
text = re.sub(pattern, new_queue, text, count=1, flags=re.DOTALL)

with open(path, "w", encoding="utf-8") as f:
    f.write(text)
print("ActionQueue fixed safely!")
