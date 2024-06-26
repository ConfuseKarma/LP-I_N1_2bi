﻿using Microsoft.AspNetCore.Mvc;
using N1_2Bi___LP1.DAO;
using N1_2Bi___LP1.Models;
using System.Data.SqlClient;
using System.Diagnostics;

namespace N1_2Bi___LP1.Controllers
{
    public class LoginController : Controller
    {
        public IActionResult Index()
        {
            return View();
            
        }

        public IActionResult FazLogin(string email, string senha)
        {
            using (SqlConnection conexao = ConexaoBD.GetConexao())
            {
                string query = "SELECT Id, IsAdmin FROM Usuarios WHERE Email = @Email AND Senha = @Senha";
                SqlCommand cmd = new SqlCommand(query, conexao);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@Senha", senha);

                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    int userId = reader.GetInt32(0);
                    bool isAdmin = reader.GetBoolean(1);

                    if (isAdmin)
                    {
                        HttpContext.Session.SetString("Role", "Admin");
                    }
                    else
                    {
                        HttpContext.Session.SetString("Role", "User");
                    }

                    HttpContext.Session.SetInt32("UserId", userId);
                    HttpContext.Session.SetString("Logado", "true");

                    return RedirectToAction("Index", "Home");
                }
                else
                {
                    ViewBag.Erro = "Usuário ou senha inválidos!";
                    return View("Index");
                }
            }
        }


        public IActionResult LogOff()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index");
        }
    }


}
