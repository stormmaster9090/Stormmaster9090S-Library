### Docs
read throught he docs to learn how to use modules

## Checkboxes.lua

> [!TIP]
> You can use settings().Studio.Theme to determine which theme the checkbox is!


```lua
local module = require(script.Parent.CheckBoxes)

wait(2)

local BTN = module.newCheckBox("light")
BTN:GetCheckBox().Parent = script.Parent.ScrollingFrame


wait(5)

BTN:ChangeText("ToggleLight")

wait(5)

local newbtn = module.newCheckBox("dark")
newbtn:GetCheckBox().Parent = script.Parent.ScrollingFrame

```
This creates a btn with light theme and changes the text 5 seconds and then creates a new dark checkbox
