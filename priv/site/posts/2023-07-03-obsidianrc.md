+++
date = 2023-07-23
title = "obsidianrc - a programmer's approach to obsidian"
page_title = "obsidian"
+++

my biggest hangup with obsidian has always been that it isn't vim. as a longtime vim user i'm used to being able to fully customize and extend my editing experience.

there are many existing community plugins that make it easy to customize some parts of obsidian but whenever i would have an idea or a desired workflow that didn't fit into one of those existing boxes i was stuck.

i had three options, roughly in order of immediate work required:

1. adapt my own workflows to fit the existing options
1. contribute to an existing community plugin and hope that the original author has time to review, merge in, and publish my change
1. build my own plugin to do exactly what i want

so today i had an idea for another, hopefully easier option: obsidianrc

an obsidianrc is a personal, custom plugin that resembles an "[rc](https://superuser.com/questions/144339/vimrc-screenrc-bashrc-kshrc-etc-what-does-the-rc-mean)" file like a `.vimrc`. it has no one purpose but instead is a grab-bag of whatever the author needed at the time. an obsidian user's obsidianrc evolves with her as she comes up with new workflows or changes her existing workflows.

the freedom of the obsidianrc is that it never needs to be used by anyone but its author. it's a workbench covered in jigs. if any bit of functionality ever sticks out as generally useful the code is easily (famous last words perhaps...) extracted into its own plugin and published in the community plugin repo.

## create your own obsidianrc 

1. use the [obsidian-sample-plugin](https://github.com/obsidianmd/obsidian-sample-plugin) template
1. name your repo `obsidianrc`
1. install your obsidianrc in your vault
1. fill your obsidianrc with whatever need whenever you need it
1. (optional) use [BRAT](https://github.com/TfTHacker/obsidian42-brat) to install your obsidianrc and keep it up-to-date

## what's in my obsidianrc?

well at time of writing, not much. but you can take a look for yourself: [sloanelybutsurely/obsidianrc](https://github.com/sloanelybutsurely/obsidianrc)
