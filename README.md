<!-- SPDX-License-Identifier: CC-BY-NC-SA-4.0 -->

# Mage Sheet

This repository contains an early draft of translating the Mage character sheet into HTML.

This is a proof-of-concept being tried in a single game to explore the impact of having change history in `git` and collaborative editing between GM and player of the character sheet, and story notes, over time.

At the moment, the character sheet is a single `.html` file as that makes sharing easy for someone to copy and modify.

If it proves useful, it would likely make sense to break out the character data (in to a `.json` file), and possibly extract the CSS and JavaScript into separate files as well.

Yes, the layout is cringe-worthy, and the style is ugly.
If it proves useful, time could be invested in cleaning it up.
Please feel free to copy it, use it, modify according to the license.

## Contributing

There are some `TODO` notes in the HTML.
Create an [issue](https://github.com/jd-collab/mage-sheet/issues) and maybe a draft [pull request](https://github.com/jd-collab/mage-sheet/pulls).

## Deploying

Changes to the `main` branch are automatically deployed to [https://jd-collab.github.io/mage-sheet/](https://jd-collab.github.io/mage-sheet/) via GitHub pages automation.

## Licensing

Content in this repository is made available under the Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International Public License.
