// Reuse and adapt fecharCaixa logic
function carregarVendasHoje() {
  fetch("http://localhost:3000/vendas")
    .then(res => res.json())
    .then(vendas => {
      const hoje = new Date();
      const vendasHoje = vendas.filter(venda =>
        new Date(venda.data).toDateString() === hoje.toDateString()
      );

      renderVendas(vendasHoje);
      atualizarTotalCaixa(vendasHoje);
    })
    .catch(err => {
      console.error(err);
      alert("Erro ao carregar vendas");
    });
}

function renderVendas(vendas) {
  const lista = document.getElementById("lista-vendas-caixa");
  lista.innerHTML = "";

  if (vendas.length === 0) {
    lista.innerHTML = `<p style="text-align: center; color: #6b7280;">Nenhuma venda registrada para hoje</p>`;
    return;
  }

  vendas.forEach(venda => {
    const dataFormatada = new Date(venda.data).toLocaleTimeString("pt-BR", {
      hour: "2-digit",
      minute: "2-digit"
    });

    const itensHTML = venda.itens.map(item => 
      `<span style="display: block; font-size: 14px; font-weight: bold; color: #374151;">x${item.quantidade} ${item.nome_produto}</span>`
    ).join("");

    const vendaItem = document.createElement("div");
    vendaItem.className = "venda-item";
    vendaItem.innerHTML = `
      <div class="venda-info">
        <span class="venda-data">${dataFormatada}</span>
        ${itensHTML}
      </div>
      <span class="venda-total">R$ ${venda.total.toFixed(2)}</span>
    `;

    lista.appendChild(vendaItem);
  });
}

function atualizarTotalCaixa(vendas) {
  const total = vendas.reduce((sum, venda) => sum + venda.total, 0);
  document.getElementById("total-caixa").innerText = `R$ ${total.toFixed(2)}`;
}

function voltarPagina() {
  window.location.href = "/src/html/pagina-inicial.html";
}

// Adapted from pagina-inicial.js fecharCaixa()
function confirmarFechamento() {
  fetch("http://localhost:3000/vendas")
    .then(res => res.json())
    .then(vendas => {
      const hoje = new Date();
      const vendasHoje = vendas.filter(venda =>
        new Date(venda.data).toDateString() === hoje.toDateString()
      );

      if (vendasHoje.length === 0) {
        alert("Nenhuma venda registrada para hoje");
        return;
      }

      const totalHoje = vendasHoje.reduce((sum, venda) => sum + venda.total, 0);
      const vendaIds = vendasHoje.map(venda => venda.id);

      const confirmou = confirm(
        `Confirmar fechamento de caixa com total R$ ${totalHoje.toFixed(2)}?`
      );

      if (!confirmou) return;

      return fetch("http://localhost:3000/caixas", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          data: hoje.toISOString(),
          dia: hoje.getDate(),
          mes: hoje.getMonth() + 1,
          ano: hoje.getFullYear(),
          total: totalHoje,
          venda_ids: vendaIds
        })
      });
    })
    .then(() => {
      alert("Caixa fechado com sucesso!");
      window.location.href = "/src/html/pagina-inicial.html";
    })
    .catch(err => {
      console.error(err);
      alert("Erro ao confirmar fechamento");
    });
}

window.onload = function() {
  carregarVendasHoje();
};