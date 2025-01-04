const String server = "http://192.168.0.112:5000"; // 192.168.16.112

class AppEndpoints {

  static String endpointGetImagemUsuario(int idUser) {
    return "$server/v1/scissor/usuario/foto?id_user=$idUser";
  }

  static String endpointGetImagemBarbearia(int id) {
    return "$server/v1/scissor/barbearia/image?id_barbearia=$id";
  }

  static String endpointImagemUsuario = "$server/v1/scissor/usuario/foto";
  static String endpointUsuario = "$server/v1/scissor/usuario";
  static String endpointBarbearia = "$server/v1/scissor/barbearia";
  static String endpointBarbeariaAvaliar = "$server/v1/scissor/barbearia/avaliar";
  static String endpointPromocao = "$server/v1/scissor/servicos/promocao";
  static String endpointServicos = "$server/v1/scissor/servicos";
  static String endpointAgendamentos = "$server/v1/scissor/agendamentos";
}
