This module provisions the necessary sofware repository mirrors to deploy OpenStack according to the HUIT procedure.  It uses [mrepo](http://dag.wiee.rs/home-made/mrepo/) to mirror remote repositories.

### Testing

To test, clone [vagrant-generic](https://github.com/huit/vagrant-generic) and check out the `openstack_mirrors` branch, then run `vagrant up`.  Note that at present this will only configure mrepo and Apache, not actually run the mirroring process; to test that, either wait until 2:30AM :) or run `mrepo -ug -vv` as root.  Beware of filling your disk!  Mirroring will take a LONG time.

License
-------


Contact
-------


Support
-------

Please log tickets and issues at our [Projects site](http://projects.example.com)
