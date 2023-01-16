# qemu-recipes

A collection of shell scripts (recipes) with well documented qemu options. 
Using a recipe is just creating a copy of the desired shell script, modifying
a few options such as cdrom image and running it.

Things this repository already contains and things I would like it to contain soon™:

- launching VMs with common settings
- creating and destroying a bridged network setup so all VMs can access each other and the internet
- creating snapshots
- TODO: launching VMs with settings specific to certain OS
- TODO: hardware pass through (including GPU)
- TODO: some container recipes with podman

## Usage

Clone this repo and change the options on the scripts. You will probably want to:

1. `chmod +x`
2. Setup the network with `create-bridged-network.sh`
3. Create a new disk with `create-disk.sh`
4. Start the VM with `boot-vm.sh`

All files contain comments explaining what needs to be changed.

## Networking

Currently the only networking recipe is for bridged network because that's the one I find most useful
but I'm not opposed to more recipes if you would like to make a pull request.

The bridged networking recipe uses an ephemeral setup, if you reboot all the interfaces disappear.
This was deliberate because I don't like having a virbr0 interface polluting my system when I'm not using
virtualization. The recipe also includes instructions on how to undo the setup without rebooting.

I might still add a permanent bridged network setup because running the current recipe resets the network
connection.x

## Motivation

I was very unsatisfied with all exiting hypervisors for different reasons, terrible interfaces, lacking features,
too many features, XML config files (you know who), poor documentation or proprietary.

When I wrote these recipes I had magit in mind (an emacs git interface), it takes an extremely
complex software (git) and simplifies it by exposing common use cases (recipes) you can depart from if need be.

I hope to accomplish the same here, to take an extremely complex software (qemu) and simplify it by
exposing common use cases in the form shell scripts (recipes) which should contain enough documentation and
references for the user to be able to depart from it if need be.

## License

Do whatever the fuck you want I don't care it's just a bunch of scripts.
