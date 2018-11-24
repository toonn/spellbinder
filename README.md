Spellbinder
===========

Declaratively manage a directory tree and a corresponding set of bind mounts.

Example use case
----------------

Imagine you have a media library you want to share over the network. It's
organized to your liking and filled with embarrassing things like DBZ, Glee
or any song by Celine Dion. NFS or something similar'll take care of your
sharing needs but how do you hide your meticulous (opinionated) organization
scheme, featuring such beauties as `boring_stuff_friends_recommended`, not to
mention your guilty pleasures "Kamehameha!"

Spellbinder can help you. You specify the things you want to share and it'll
take care of all the nitty gritty details like adding or removing mountpoints
and all the bind mounts.

---

> Note: This is likely a case of NIH. I'm sure there's other solutions out there
that either do what I'm trying to do or something similar. Configuration
management solutions like ansible come to mind.
  Please show me the error of my ways, in the form of more elegant approaches.
