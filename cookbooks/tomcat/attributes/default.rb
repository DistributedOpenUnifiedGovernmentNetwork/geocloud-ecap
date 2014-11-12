#
# Cookbook Name:: tomcat
# Attributes:: default
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

default['tomcat']['package']['full_version'] = '7.0.53-1'
default['tomcat']['package']['s3_bucket_path'] = 'femadata-sandbox-public/tomcat7/rpm'
default['tomcat']['base_version'] = 6
default['tomcat']['port'] = 8080
default['tomcat']['proxy_port'] = nil
default['tomcat']['ssl_port'] = 8443
default['tomcat']['ssl_proxy_port'] = nil
default['tomcat']['ajp_port'] = 8009
default['tomcat']['shutdown_port'] = 8005
default['tomcat']['catalina_options'] = ''
default['tomcat']['java_options'] = '-Xmx128M -Djava.awt.headless=true'
default['tomcat']['use_security_manager'] = false
default['tomcat']['authbind'] = 'no'
default['tomcat']['deploy_manager_apps'] = true
default['tomcat']['max_threads'] = nil
default['tomcat']['ssl_max_threads'] = 150
default['tomcat']['ssl_cert_file'] = nil
default['tomcat']['ssl_key_file'] = nil
default['tomcat']['ssl_chain_files'] = []
default['tomcat']['keystore_file'] = 'keystore.jks'
default['tomcat']['keystore_type'] = 'jks'
default['tomcat']['pkcs12_password'] = nil
default['tomcat']['pkcs12_cert'] = nil
# The keystore and truststore passwords will be generated by the
# openssl cookbook's secure_password method in the recipe if they are
# not otherwise set. Do not hardcode passwords in the cookbook.
# default["tomcat"]["keystore_password"] = nil
# default["tomcat"]["truststore_password"] = nil
default['tomcat']['truststore_file'] = nil
default['tomcat']['truststore_type'] = 'jks'
default['tomcat']['certificate_dn'] = 'cn=localhost'
default['tomcat']['loglevel'] = 'INFO'
default['tomcat']['tomcat_auth'] = 'true'
default['tomcat']['instances'] = {}
default['tomcat']['run_base_instance'] = true

default['tomcat']['jndi'] = false
default['tomcat']['jndi_connections'] = []

default['tomcat']['ad']['integration'] = false
default['tomcat']['ad']['dc1'] = "dc1.egt.local"
default['tomcat']['ad']['dc2'] = "dc2.egt.local"
default['tomcat']['ad']['domain_name'] = "egt.local"
default['tomcat']['ad']['user_base'] = "OU=egt,DC=egt,DC=local"
default['tomcat']['ad']['role_base'] = node.tomcat.ad.user_base
default['tomcat']['ad']['ldap_port'] = 389
default['tomcat']['ad']['group'] = "Tomcat Admins"
default['tomcat']['ad']['auth'] = {
	'data_bag' => 'active_directory',
	'data_bag_item' => "tomcat"
}


case node['platform']

when 'centos', 'redhat', 'fedora', 'amazon', 'scientific', 'oracle'
  default['tomcat']['user'] = 'tomcat'
  default['tomcat']['group'] = 'tomcat'
  default['tomcat']['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['base'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['tmp_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}/temp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}/work"
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default['tomcat']['app_base'] = "webapps"
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
when 'debian', 'ubuntu'
  default['tomcat']['user'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['group'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['base'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['tmp_dir'] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
  default['tomcat']['app_base'] = "webapps"
when 'smartos'
  default['tomcat']['user'] = 'tomcat'
  default['tomcat']['group'] = 'tomcat'
  default['tomcat']['home'] = '/opt/local/share/tomcat'
  default['tomcat']['base'] = '/opt/local/share/tomcat'
  default['tomcat']['config_dir'] = '/opt/local/share/tomcat/conf'
  default['tomcat']['log_dir'] = '/opt/local/share/tomcat/logs'
  default['tomcat']['tmp_dir'] = '/opt/local/share/tomcat/temp'
  default['tomcat']['work_dir'] = '/opt/local/share/tomcat/work'
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = '/opt/local/share/tomcat/webapps'
  default['tomcat']['keytool'] = '/opt/local/bin/keytool'
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["home"]}/lib/endorsed"
  default['tomcat']['app_base'] = "webapps"
else
  default['tomcat']['user'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['group'] = "tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['home'] = "/usr/share/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['base'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['config_dir'] = "/etc/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['log_dir'] = "/var/log/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['tmp_dir'] = "/tmp/tomcat#{node["tomcat"]["base_version"]}-tmp"
  default['tomcat']['work_dir'] = "/var/cache/tomcat#{node["tomcat"]["base_version"]}"
  default['tomcat']['context_dir'] = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
  default['tomcat']['webapp_dir'] = "/var/lib/tomcat#{node["tomcat"]["base_version"]}/webapps"
  default['tomcat']['keytool'] = 'keytool'
  default['tomcat']['lib_dir'] = "#{node["tomcat"]["home"]}/lib"
  default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"
  default['tomcat']['app_base'] = "webapps"
end
