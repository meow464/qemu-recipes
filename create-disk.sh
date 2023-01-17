#!/usr/bin/env bash

# Creates a new disk

# -f
# Specifies the format, most common options are qcow2, raw, vdi and vmdk
# qcow2 is only as large as the data inside it and supports copy on write
# when created from a backing image.

qemu-img create -f qcow2 disk.qcow2 20G


# -o backing_file=
# Specifies the backing file for the new image  qemu will copy-on-write
# any changes made. Useful for snapshots. I'm not sure if this is the
# most correct method to create snapshots.

#qemu-img create -f qcow2 -o backing_file=disk.qcow2 disk_year_month_day.qcow2 20G


# References:
# Qemu recipes: https://eaasi.gitlab.io/program_docs/qemu-qed/recipes/
