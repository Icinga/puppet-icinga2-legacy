# Setup repositories yum for Icinga
#
class icinga2::repo::chocolatey {
  # Include the chocolatey module's base class so we can set up chocolatey prior to installing the package.
  include ::chocolatey
}
