import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  Recordar instalar el paquete de:
    shared_preferences:

  Inicializar en el main
    final prefs = new PreferenciasUsuario();
    await prefs.initPrefs();

    Recuerden que el main() debe de ser async {...

*/

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del nombre
  get token {
    return _prefs.getString('token') ?? '';
  }

  set token( String value ) {
    _prefs.setString('token', value);
  }

  get celtoken {
    return _prefs.getString('celtoken')??'';
  }

  set celtoken( String value ) {
    _prefs.setString('celtoken', value);
  }

  get dni {
    return _prefs.getString('dni')??'';
  }
  set dni( String value ){
    _prefs.setString('dni', value);
  }

  get tipoUsuario {
    return _prefs.getString('tipoUsuario');
  }

  set tipoUsuario( String value ) {
    _prefs.setString('tipoUsuario', value);
  }

  get fotoUsuario {
    return _prefs.getString('fotoUsuario');
  }

  set fotoUsuario( String value ) {
    _prefs.setString('fotoUsuario', value);
  }

  get nombreUsuario {
    return _prefs.getString('nombreUsuario');
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombreUsuario', value);
  }

    get apellido {
    return _prefs.getString('apellido');
  }

  set apellido(String value) {
    _prefs.setString('apellido', value);
  }

  // GET y SET de la última página
  get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? 'login';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

  get cargo {
    return _prefs.getInt('cargo');
  }
  set cargo(int value){
    _prefs.setInt('cargo', value);
  }

  get telefono {
    return _prefs.getString('telefono');
  }
  set telefono(String value){
    _prefs.setString('telefono', value);
  }

  get dnijefe {
    return _prefs.getString('usuario_dni_jefe');
  }
  set dnijefe(String value){
    _prefs.setString('usuario_dni_jefe', value);
  }

  get idStateWorking {
    return _prefs.getInt('stateWorking');
  }
  set idStateWorking(int value){
    _prefs.setInt('stateWorking', value);
  }

  get idLunch{
    return _prefs.getInt('idlunch');
  }
  set idLunch(int value){
    _prefs.setInt('idlunch', value);
  }

  String transformar(DateTime fecha){
    String result = DateFormat("yyyy-MM-dd").format(fecha);
    return result;
  }

  get ultimoIngreso{
    return _prefs.getString('empleado_ultimo_ingreso');
  }

  set ultimoIngreso(DateTime value){
    _prefs.setString('empleado_ultimo_ingreso',transformar(value));
  }

  
  get idEmpresa{
    return _prefs.getString('empleado_ultimo_ingreso');
  }

  set idEmpresa(String value){
    _prefs.setString('empleado_ultimo_ingreso',value);
  }

}

