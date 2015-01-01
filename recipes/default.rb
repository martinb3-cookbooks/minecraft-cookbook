#
# Cookbook Name:: minecraft
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'mineos'

node.set_unless['iptables']['rules'] = []

rule25565 = {
  name: "port_25565",
  value: "-A FWR -p udp -m udp --dport 25565 -j ACCEPT"
}
node.set['iptables']['rules'] << rule25565 if node['iptables']['rules'].select { |r| r[:name] == rule25565[:name] }.empty?

ports = [8080]

ports.each do |p|
  rule = {
    name: "port_#{p}",
    value: "-A FWR -p tcp -m tcp --dport #{p} -j ACCEPT"
  }
  node.set['iptables']['rules'] << rule if node['iptables']['rules'].select { |r| r[:name] == rule[:name] }.empty?
end
