enum Selection{
  PRODUCTOS,
  MATERIALES,
  ADMINISTRACION,
  PERFIL,
  SETTINGS,
  HELP
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
      case Selection.SETTINGS:
        return 'Preferencias';
        break;
      case Selection.HELP:
        return 'Ayuda';
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
      case Selection.SETTINGS:
        return 'Preferencias';
        break;
      case Selection.HELP:
        return 'Ayuda';
        break;
    }
  }
}