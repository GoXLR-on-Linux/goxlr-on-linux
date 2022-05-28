# Pipewire Support
Pipewire was originally supported on Kernel 5.10 with the latest [Alsa UCM](https://github.com/alsa-project/alsa-ucm-conf), however, due to a kernel issue introduced in [bf6313a](https://github.com/torvalds/linux/commit/bf6313a0ff766925462e97b4e733d5952de02367) audio output on the GoXLR stopped working.

We've been working with the kernel developers and the patch introduced at [0e85a22d0](https://github.com/torvalds/linux/commit/0e85a22d01dfe9ad9a9d9e87cd4a88acce1aad65) resolves the issue completely, and the GoXLR functions correctly again with the UCM profiles, and thus, correctly under the Pipewire environment, with no need for scripts or special configuration. This patch is currently scheduled to be mainlined in Kernel 5.19.

In our experiementation, that patch will correctly apply to any 5.15(LTS)+ kernel provided with most recent linux distributions, but it does currently require manual compilation. The GoXRL on Linux team are working on a possible DKMS setup to automate the patch and fix for LTS distributions, and will advise here of their progress as it occurs, we're currently hoping to have this out in the next week or so, with caveats (there are many distributions to test, and it's not a fast process).

If you're comfortable enough to apply kernel patches yourself, and are running a minimum 5.15 kernel, you can use the patch linked above to enable your GoXLR fully under pipewire.

We'll otherwise keep people informed on [Discord](https://discord.gg/Wbp3UxkX2j), and keep this documentation updated, as to our progress on trying to enable the GoXLR on as many distributions under pipewire as possible.
