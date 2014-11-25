#Changelog
- - -

###v0.6.1 (unreleased)

* Feature: [PR-54](https://github.com/Icinga/puppet-icinga2/pull/54) and [dev.icinga.org issue #7225](https://dev.icinga.org/issues/7225): Added a CompatLogger object defined type.
* Feature: [PR-55](https://github.com/Icinga/puppet-icinga2/pull/55) and [dev.icinga.org issue #7226](https://dev.icinga.org/issues/7226): Added a CheckResultReader object defined type.
* Feature: Added a parameter that controls whether to purge unmanaged files in `/etc/icinga2/objects/`

###v0.6.0 (November 19th, 2014)

* Added a defined type for `ServiceGroup` objects
* Bug [#7189](https://dev.icinga.org/issues/7189): Fixed `liddir` typo in some manifests
* Bug [#7190](https://dev.icinga.org/issues/7190): Fully qualify uses of the `operatingsystem` Facter fact
* Added CentOS 7 support
* Feature [#7264](https://dev.icinga.org/issues/7264): Added Debian 7 support
* Feature: Added the ability to use the Debmon repository on Debian 7 systems: [PR-17](https://github.com/Icinga/puppet-icinga2/pull/17)
* Feature: Added the ability to make NRPE accept command arguments; turned off by default for obvious security reasons: [PR-22](https://github.com/Icinga/puppet-icinga2/pull/22)
* Feature: Added the ability to enable/disable Icinga 2 components via parameters: [PR-23](https://github.com/Icinga/puppet-icinga2/pull/23)
* Feature: Added a `GraphiteWriter` object defined type: [PR-24](https://github.com/Icinga/puppet-icinga2/pull/24)
* Feature: Added the ability to upload or create custom check plugins on an Icinga 2 server (as opposed to just for NRPE clients): [PR-27](https://github.com/Icinga/puppet-icinga2/pull/27)
* Bug [#7308](https://dev.icinga.org/issues/7308): Allow multiple `assign_where` and `ignore_where` conditions
* Feature: [PR-28](https://github.com/Icinga/puppet-icinga2/pull/28) and issue [#7219](https://dev.icinga.org/issues/7219): Added Dependecy and Apply Dependency objects
* Feature: [PR-29](https://github.com/Icinga/puppet-icinga2/pull/29) and issue [#7213](https://dev.icinga.org/issues/7213): Added a CheckCommand object defined type
* Feature: [PR-32](https://github.com/Icinga/puppet-icinga2/pull/32): Added a NotificationCommand object.
* Feature: [PR-33](https://github.com/Icinga/puppet-icinga2/pull/33): Added an EventCommand object.
* Feature: [PR-35](https://github.com/Icinga/puppet-icinga2/pull/35): Added the ability to use a static file or custom ERB template for check command objects
* Feature: [PR-36](https://github.com/Icinga/puppet-icinga2/pull/36) and [dev.icinga.org issue #7216](https://dev.icinga.org/issues/7216): Added a [Notification](http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-notification) object defined type.
* Feature: [PR-37](https://github.com/Icinga/puppet-icinga2/pull/37) and [dev.icinga.org issue #7217](https://dev.icinga.org/issues/7217): Added a [TimePeriod](http://docs.icinga.org/icinga2/latest/doc/module/icinga2/chapter/configuring-icinga2#objecttype-timeperiod) object defined type.
* Feature: [PR-39](https://github.com/Icinga/puppet-icinga2/pull/39) and [dev.icinga.org issue #7673](https://dev.icinga.org/issues/7673): Added the ability to purge non-Puppet managed NRPE config files.
* Feature: [PR-41](https://github.com/Icinga/puppet-icinga2/pull/41) and [dev.icinga.org issue #7674](https://dev.icinga.org/issues/7674): Added CentOS 5 server and NRPE client support.
* Fix: [PR-40](https://github.com/Icinga/puppet-icinga2/pull/40) and [dev.icinga.org issue #7675](https://dev.icinga.org/issues/7675): Escape single quotes around the `PGPASSWORD` environment variable so that single quotes can be used in the Postgres password
* Fix: [PR-42](https://github.com/Icinga/puppet-icinga2/pull/42): Fix anchor links in the README
* Feature: [PR-43](https://github.com/Icinga/puppet-icinga2/pull/43) and [dev.icinga.org issue #7676](https://dev.icinga.org/issues/7676): Added a defined type that can create objects that apply notifications to hosts
* Feature: [PR-44](https://github.com/Icinga/puppet-icinga2/pull/44) and [dev.icinga.org issue #7677](https://dev.icinga.org/issues/7677): Added a defined type that can create objects that apply notifications to services
* Feature: [PR-45](https://github.com/Icinga/puppet-icinga2/pull/45) and [dev.icinga.org issue #7220](https://dev.icinga.org/issues/7220): Added a defined type for PerfDataWriter objects
* Feature: [PR-47](https://github.com/Icinga/puppet-icinga2/pull/47) and [dev.icinga.org issue #7220](https://dev.icinga.org/issues/7220): Added a defined type for PerfDataWriter objects
* Feature: [PR-48](https://github.com/Icinga/puppet-icinga2/pull/48) and [dev.icinga.org issue #7222](https://dev.icinga.org/issues/7222): Added a defined type for LiveStatusListener objects
* Feature: [PR-49](https://github.com/Icinga/puppet-icinga2/pull/49) and [dev.icinga.org issue #7223](https://dev.icinga.org/issues/7223): Added a defined type for StatusDataWriter objects
* Feature: [PR-50](https://github.com/Icinga/puppet-icinga2/pull/50) and [dev.icinga.org issue #7224](https://dev.icinga.org/issues/7224): Added a defined type for ExternalCommandListener objects
* Fix: [dev.icinga.org issue #7715](https://dev.icinga.org/issues/7715): Allow trailing whitespace after some parameters so that the parameters following it don't get squashed onto the same line.
* Fix: [dev.icinga.org issue #7716](https://dev.icinga.org/issues/7716): Add a `target_file_ensure` parameter to each object file that gets passed through to the underlying file resource's `ensure =>` parameter.

###v0.5 (August 17th, 2014)

* Added a defined type for the `User` Icinga 2 object type

###v0.4 (August 2nd, 2014)

* Added object definitions for service objects and apply objects that
  apply services to hosts
* Added a `Modulefile` and a `metadata.json`

###v0.3 (July 26th, 2014)

* Added an object definition for the **host** object type
