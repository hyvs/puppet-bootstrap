class p::system {

  contain p::system::repos
  contain p::system::locales
  contain p::system::kernel
  contain p::system::network
  contain p::system::firewalls
  contain p::system::packages
  contain p::system::hosts
  contain p::system::users
  contain p::system::directories
  contain p::system::files
  contain p::system::links
  contain p::system::crons
  contain p::system::ssh
  contain p::system::commands

}