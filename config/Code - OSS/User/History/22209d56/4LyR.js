function criarCard(produto) {
  return `
    <div class="card">
      <h3>Produto: ${produto.nome_produto}</h3>

      <p>Preço: R$ ${produto.valor_produto}</p>
      <p>Estoque: ${produto.qtde_produto}</p>

      <div class="card-buttons">
       <a href="/src/html/editar_produto.html"> <button class="btn-editar">
           Editar
        </button>
          </a>

        <button 
          class="btn-adicionar"
    onclick="adicionarAoCarrinho('${produto.id}')"   
        >
          + Adicionar
        </button>
      </div>
    </div>
  `;
}
let produtosCache = [];


function carregarProdutos() {
  fetch("http://localhost:3000/produtos")
    .then(res => res.json())
    .then(produtos => {
      produtosCache = produtos;
      renderProdutos(produtosCache);
    });
}

const inputBusca = document.getElementById("input-busca");
inputBusca.addEventListener("input", function () {
  pesquisarItem(inputBusca.value);
});

function renderProdutos(produtos) {
  const lista = document.getElementById("lista-produtos");
  let html = "";

  produtos.forEach(produto => {
    html += criarCard(produto);
  });

  lista.innerHTML = html;
}

function pesquisarItem(termoBusca) {
  const pesquisa = termoBusca.trim().toLowerCase();

  if (!pesquisa) {
    renderProdutos(produtosCache);
    return;
  }

  const resultados = produtosCache.filter(produto => {
    return produto.nome_produto.toLowerCase().includes(pesquisa);
  });

  renderProdutos(resultados);
}

function adicionarAoCarrinho(idProduto) {

  fetch(`http://localhost:3000/produtos/${idProduto}`)
    .then(res => res.json())
    .then(produto => {

      fetch("http://localhost:3000/carrinho")
        .then(res => res.json())
        .then(carrinho => {

          const itemExistente = carrinho.find(item =>
            item.nome_produto === produto.nome_produto
          );

          if (itemExistente) {
            fetch(`http://localhost:3000/carrinho/${itemExistente.id}`, {
              method: "PATCH",
              headers: {
                "Content-Type": "application/json"
              },
              body: JSON.stringify({
                quantidade: itemExistente.quantidade + 1
              })
            })
              .then(() => carregarCarrinho());

          } else {
            const item = {
              id_produto: produto.id, 
              nome_produto: produto.nome_produto,
              quantidade: 1,
              preco_unitario: produto.valor_produto
            };

            fetch("http://localhost:3000/carrinho", {
              method: "POST",
              headers: {
                "Content-Type": "application/json"
              },
              body: JSON.stringify(item)
            })
              .then(() => carregarCarrinho());
          }

        });

    });
}

// Essa é a função de carregar o carrinho!
function carregarCarrinho() {
  fetch("http://localhost:3000/carrinho")
    .then(res => res.json())
    .then(carrinho => {

      const div = document.getElementById("lista-carrinho");
      div.innerHTML = "";

      carrinho.forEach(item => {
        const valorFinalItem = item.preco_unitario * item.quantidade;
        div.innerHTML += `
          <div class="item-carrinho">
            <p>${item.nome_produto}</p>
            <button onclick="diminuirQuantidade('${item.id}')">-</button> <button onclick="aumentarQuantidade('${item.id}')">+</button>
            <p>Qtd: ${item.quantidade}</p>
            <p>R$ ${valorFinalItem.toFixed(2)}</p>            
            <button onclick="removerDoCarrinho('${item.id}')">X</button>
          </div>
          <hr>
        `;
      });

      atualizarTotal(carrinho);
    });
}

//Essa é a função de remover do carrinho!

function removerDoCarrinho(itemId) {
  fetch(`http://localhost:3000/carrinho/${itemId}`, {
    method: "DELETE"
  })
    .then(response => {
      if (!response.ok) {
        throw new Error("Erro ao remover item");
      }
      carregarCarrinho();
    })
    .catch(err => window.alert("Erro ao remover item:", err));
}

// Essa é a função que diminui quantidade do carrinho;


function diminuirQuantidade(itemId) {
  fetch(`http://localhost:3000/carrinho/${itemId}`)
    .then(res => res.json())
    .then(item => {
      if (item.quantidade > 1) {
        fetch(`http://localhost:3000/carrinho/${itemId}`, {
          method: "PATCH",
          headers: { "Content-Type": "application/json" },
          body: JSON.stringify({ quantidade: item.quantidade - 1 })
        })
          .then(() => carregarCarrinho())
          .catch(err => window.alert("Não foi possível diminuir quantidade:", err));
      } else {
        removerDoCarrinho(itemId);
      }
    });
}

// Essa é a função que aumenta quantidade do carrinho;
function aumentarQuantidade(itemId) {
  fetch(`http://localhost:3000/carrinho/${itemId}`)
    .then(res => res.json())
    .then(item => {
      fetch(`http://localhost:3000/carrinho/${itemId}`, {
        method: "PATCH",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ quantidade: item.quantidade + 1 })
      })
        .then(() => carregarCarrinho())
        .catch(err => window.alert("Não foi possível aumentar quantidade:", err));
    });
}

// Essa é a função que atualiza o total do carrinho!
function atualizarTotal(carrinho) {
  let total = 0;

  carrinho.forEach(item => {
    total += item.quantidade * item.preco_unitario;
  });

  document.getElementById("total").innerText = `R$ ${total.toFixed(2)}`;
}

window.onload = function () {
  carregarProdutos();
  carregarCarrinho();
};



function atualizarEstoque(carrinho) {

  const updates = carrinho.map(item => {

    return fetch(`http://localhost:3000/produtos/${item.id_produto}`)
      .then(res => res.json())
      .then(produto => {
        const novoEstoque = produto.qtde_produto - item.quantidade;

        if (novoEstoque < 0) {
          alert(`Estoque insuficiente para ${produto.nome_produto}`);
          throw new Error("Estoque insuficiente");
        }
        return fetch(`http://localhost:3000/produtos/${item.id_produto}`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json"
          },
          body: JSON.stringify({
            qtde_produto: novoEstoque
          })
        });
      });
  });
  return Promise.all(updates);
}



// essa é a funçâo para fechar vendas!
function fecharVenda() {
  fetch("http://localhost:3000/carrinho")
    .then(res => res.json())
    .then(carrinho => {
      if (carrinho.length === 0) {
        alert("Carrinho vazio!");
        return;
      }
      let total = 0;
      carrinho.forEach(item => {
        total += item.preco_unitario * item.quantidade;
      });
      atualizarEstoque(carrinho)
        .then(() => {
          return fetch("http://localhost:3000/vendas", {
            method: "POST",
            headers: {
              "Content-Type": "application/json"
            },
            body: JSON.stringify({
              data: new Date(),
              total: total,
              itens: carrinho
            })
          });
        })
        .then(() => {
          return limparCarrinho(carrinho);
        })
        .then(() => {
          alert("Venda finalizada!");
        })
        .catch(err => {
          console.error(err);
          alert("Erro ao finalizar venda");
        });

    });
}


// Essa e a função para limpar o carrinho!
function limparCarrinho(carrinho) {
  const deletes = carrinho.map(item => {
    return fetch(`http://localhost:3000/carrinho/${item.id}`, {
      method: "DELETE"
    });
  });

  return Promise.all(deletes);
}
