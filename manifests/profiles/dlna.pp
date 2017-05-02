# Setting up a dlna access point
class pi::profiles::dlna {
  include pi::minidlna
  include pi::gateway
  include pi::hostapd
}
