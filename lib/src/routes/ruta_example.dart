// ruta del endpoint
class EndPoints {
  // ruta padre
  String rutaEndPoint = 'http://localhost:8081/';
  // ruta de acceso AUTENTICACIÓN
  String pathAutenticacionUser = '/api/autenticacion/loginUser';
  String pathAutenticacionAdmin = '/api/autenticacion/loginAdmin';
  String pathVerificarCodigo = '/api/autenticacion/verificar';
  String pathEnviarCodigoEmail = '/api/autenticacion/enviarCodigo';
  String pathCambiarClave = '/api/autenticacion/comprobarCodigo';
  // ruta de acceso LOOKHERE
  String pathUsuario = '/api/lookhere/usuario';
  String pathRol = '/api/lookhere/rol';
  String pathPersona = '/api/lookhere/persona/';
  String pathPersonaIdentidad = '/api/lookhere/personaIdentidad';
  String pathEnfermedad = '/api/lookhere/enfermedad/';
  String pathFamiliar = '/api/lookhere/familiar/';
  String pathFamiliarIdPersona = '/api/lookhere/familiarIdPersona/';
  String pathProvincia = '/api/lookhere/provincia/';
  String pathCiudad = '/api/lookhere/ciudad/';
  String pathPerfil = '/api/lookhere/datosPerfil/';
  String pahtPerfilRegistro = '/api/lookhere/datosRegistroPerfil/';
  String pathBuscarQR = '/api/lookhere/personaIdQR';
  // Validadores de credenciales como cedula etc..
  String pathUsuarioValidador = '/api/lookhere/validarUsuario';
  String pathPersonaValidador = '/api/lookhere/validarPersona';
}

// parametro para llamar las rutas en cualquier clase
final path = new EndPoints();
