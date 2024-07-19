# plugin编写模板
```lua
return {
    {
        "插件的url",
        version = "*",
        dependencies = {""},
        config = function()
            ..
            vim.cmd([[
                ..
            ]])
        end
    }
}
```

- > `version`： 可选项    
- > `dependencies`: 插件依赖的插件  
- > `config`: 用于对插件进行一些配置，vim.cmd可以用vim的指令来配置
