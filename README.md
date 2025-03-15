# MA3 Startshow Auto Groups

A GrandMA3 plugin to automatically create groups needed for the startshow showfile.

## Installation

Clone the repository using [git](https://git-scm.com/).

```bash
# Clone the repository
git clone https://github.com/bootsie123/ma3-startshow-auto-groups.git

# Enter the directory
cd ma3-startshow-auto-groups
```

Next, copy the `auto-groups.xml` file to your MA3 plugins folder: `C:\ProgramData\MALightingTechnology\gma3_library\datapools\plugins`

From there, create a new plugin in the `Plugin Pool` and then hit `Import` and select `auto-groups.xml`.

## Usage

After installing the plugin, create the `StartShow Group 1-8 Grid` groups as normal ensuring the selection grid accurately matches the real world placement of your fixtures. Once done, hit the plugin in the `Plugin Pool` to automatically create the linear, even, odd, 1/3, 2/3, and 3/3 groups.

Next, enjoy the time saved! Feel free to make adjustments to your initial groups and run the plugin again or make fine tuned adjustments to the selection grids of any of the generated groups.

### Custom Group Names

This plugin also works if the names of your groups have been changed from the default `StartShow Group` pattern. Simply ensure there exists a set of groups with the following case insensitive endings: `grid`, `linear`, `even`, `odd`, `1/3`, `2/3`, `3/3`.

## Contributing

Pull requests are welcome. Any changes are appreciated!

## License

[ISC](https://choosealicense.com/licenses/isc/)
