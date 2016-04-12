Facter.add(:i2_dirprefix) do
  confine :kernel => :windows
  setcode do
    value = nil
    require 'win32/registry'
    begin
      Win32::Registry::HKEY_LOCAL_MACHINE.open('SOFTWARE\WOW6432Node\Icinga Development Team\ICINGA2') do |reg|
        reg_typ, reg_val = reg.read('') 
        value = reg_val
        value = value.gsub("\\","/")
      end
    rescue Win32::Registry::Error
      nil
    end
    value
  end
end
Facter.add(:i2_dirprefix) do
  confine :kernel => :windows
  setcode do
    value = nil
    require 'win32/registry'
    begin
      Win32::Registry::HKEY_LOCAL_MACHINE.open('SOFTWARE\Icinga Development Team\ICINGA2') do |reg|
        reg_typ, reg_val = reg.read('')
        value = reg_val
        value = value.gsub("\\","/")
      end
    rescue Win32::Registry::Error
      nil
    end
    value
  end
end
