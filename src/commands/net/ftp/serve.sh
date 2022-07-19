@l _ net:ftp:serve net_ftp_serve Launch FTP Server
function net_ftp_serve {
  python3 - << EOF
from pyftpdlib.authorizers import DummyAuthorizer
from pyftpdlib.handlers import FTPHandler
from pyftpdlib.servers import FTPServer
authorizer = DummyAuthorizer()
authorizer.add_anonymous(".")
authorizer.add_user("admin", "admin", ".", perm="elradfmwMT")
handler = FTPHandler
handler.authorizer = authorizer
handler.passive_ports = range(60000, 65535)
FTPServer(("127.0.0.1", 10021), handler).serve_forever()
EOF
}