enum Selection{
  PRODUCTOS,
  MATERIALES,
  ADMINISTRACION,
  PERFIL,
  CONFIGURACION
}

class SelectionHelper{
  static String getSelectionString(Selection selection){
    switch(selection){
      case Selection.PRODUCTOS:
        return 'Productos';
        break;
      case Selection.MATERIALES:
        return 'Materiales';
        break;
      case Selection.ADMINISTRACION:
        return 'Administración';
        break;
      case Selection.PERFIL:
        return 'Perfil';
        break;
      case Selection.CONFIGURACION:
        return 'Configuración';
        break;
    }
  }

  static String getSingularString(Selection selection){
    switch(selection){
      case Selection.PRODUCTOS:
        return 'Producto';
        break;
      case Selection.MATERIALES:
        return 'Material';
        break;
      case Selection.ADMINISTRACION:
        return 'Usuario';
        break;
      case Selection.PERFIL:
        return 'Perfil';
        break;
      case Selection.CONFIGURACION:
        return 'Configuración';
        break;
    }
  }
}