﻿using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using N1_2Bi___LP1.DAO;
using N1_2Bi___LP1.Enums;
using N1_2Bi___LP1.Models;

namespace N1_2Bi___LP1.Controllers
{

    public class ProdutoController : PadraoController<ProdutoViewModel>
    {
        public IActionResult Index()
        {
            ProdutoDAO dao = new ProdutoDAO();
            List<ProdutoViewModel> lista = dao.Listagem();
            return View(lista);
        }

        public IActionResult Create()
        {
            try
            {
                ViewBag.Operacao = "I";
                ProdutoViewModel produto = new ProdutoViewModel();
                ProdutoDAO dao = new ProdutoDAO();
                produto.Id = dao.ProximoId();
                return View("Form", produto);
            }
            catch (Exception erro)
            {
                return View("Error", new ErrorViewModel(erro.ToString()));
            }
        }

        public IActionResult Edit(int id)
        {
            try
            {
                ViewBag.Operacao = "A";
                ProdutoDAO dao = new ProdutoDAO();
                ProdutoViewModel produto = dao.Consulta(id);
                if (produto == null)
                    return RedirectToAction("Index");
                else
                    return View("Form", produto);
            }
            catch (Exception erro)
            {
                return View("Error", new ErrorViewModel(erro.ToString()));
            }
        }

        public IActionResult Salvar(ProdutoViewModel produto, string Operacao)
        {
            try
            {
                ValidaDados(produto, Operacao);
                if (ModelState.IsValid == false)
                {
                    ViewBag.Operacao = Operacao;
                    return View("Form", produto);
                }
                else
                {
                    ProdutoDAO dao = new ProdutoDAO();
                    if (Operacao == "I")
                        dao.Inserir(produto);
                    else
                        dao.Alterar(produto);
                    return RedirectToAction("Index");
                }
            }
            catch (Exception erro)
            {
                return View("Error", new ErrorViewModel(erro.ToString()));
            }
        }

        private void ValidaDados(ProdutoViewModel produto, string operacao)
        {
            ModelState.Clear(); // Limpa os erros criados automaticamente pelo ASP.NET

            ProdutoDAO dao = new ProdutoDAO();

            // Verifica se o código já está em uso
            if (operacao == "I" && dao.Consulta(produto.Id) != null)
                ModelState.AddModelError("Id", "Código já está em uso.");

            // Verifica se o produto existe para operações de alteração
            if (operacao == "A" && dao.Consulta(produto.Id) == null)
                ModelState.AddModelError("Id", "Produto não existe.");

            // Verifica se o ID é válido
            if (produto.Id <= 0)
                ModelState.AddModelError("Id", "Id inválido!");

            // Verifica se o nome foi preenchido
            if (string.IsNullOrEmpty(produto.Nome))
                ModelState.AddModelError("Nome", "Preencha o nome.");

            // Verifica se a descrição foi preenchida
            if (string.IsNullOrEmpty(produto.Descricao))
                ModelState.AddModelError("Descricao", "Preencha a descrição.");

            // Verifica se o preço é maior que zero
            if (produto.Preco <= 0)
                ModelState.AddModelError("Preco", "O preço deve ser maior que zero.");
        }
    }




}