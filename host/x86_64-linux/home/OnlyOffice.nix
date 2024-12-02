# NOTE: Imperative part:
# 1. You need to change PSQL tables owner from root to onlyoffice, too. They don't do that automatically for some reason.
# 2. TODO: Generate JWT secret at /var/lib/onlyoffice/jwt, i.e. 9wLfMGha1YrfvWpb5hyYjZf8pvJQ3swS
# SEE: https://git.voronind.com/voronind/nixos/issues/74
{
	config,
	lib,
	...
}: {
	# services.onlyoffice = {
	# 	enable   = true;
	# 	hostname = "office.voronind.com";
	# 	jwtSecretFile = "/var/www/onlyoffice/jwt";
	#
	# 	postgresName = "onlyoffice";
	# 	postgresUser = "onlyoffice";
	# 	# postgresPasswordFile = "${pkgs.writeText "OfficeDbPassword" dbName}";
	# 	# rabbitmqUrl = "amqp://guest:guest@${config.container.module.rabbitmq.address}:${toString config.container.module.rabbitmq.port}";
	# };
}
