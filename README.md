# r_bridge

**r_bridge** is a lightweight FiveM resource designed to seamlessly bridge various frameworks, inventories, target resources, and more with the scripts developed by **r_scripts**.

## Usage

Add both `ox_lib` and `r_bridge` to your resource's `shared_scripts` (ox_lib must come first):

```lua
shared_scripts {
    '@ox_lib/init.lua',
    '@r_bridge/init.lua',
}
```

Then call the bridge API from your scripts:

```lua
bridge.framework.getPlayerJob(src)
bridge.inventory.addItem(src, item, count)
bridge.target.addLocalEntity(entity, options)
bridge.natives.playAnimation(...)
bridge.interface.notify(...)
bridge.utility.useObjectPlacer(...)
bridge.version.check(resource)
print(bridge.version.current)
```

Namespaces lazy-load on first access. Provider-based namespaces (`framework`, `inventory`, `target`) automatically detect which supported resource is running.

## Documentation

[Gitbook](https://rscripts.gitbook.io/r_scripts-docs./free-resources/r_bridge)

## Support

[Discord](https://discord.gg/TR38cZFdQk)

## License

This resource is licensed under the GNU GPLv3 License. See the [LICENSE](LICENSE) file for more details.
