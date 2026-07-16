const listaCaixas = document.getElementById("lista-caixas");

fetch("http://localhost:3000/caixas")
  .then(res => res.json())
  .then(caixas => {
    if (caixas.length === 0) {
      listaCaixas.innerHTML = `<p>Nenhum fechamento de caixa registrado.</p>`;
      return;
    }

    caixas.forEach(caixa => {
      const data = new Date(caixa.data);
      const dataFormatada = data.toLocaleDateString("pt-BR");
      const horaFormatada = data.toLocaleTimeString("pt-BR", {
        hour: "2-digit",
        minute: "2-digit"
      });

      const item = document.createElement("div");
      item.className = "caixa-item";
      item.innerHTML = `
        <div class="caixa-meta">
          <p><strong>Data:</strong> ${dataFormatada} ${horaFormatada}</p>
          <p class="caixa-total">Total R$ ${caixa.total.toFixed(2)}</p>
        </div>
        <p><strong>Vendas registradas:</strong> ${caixa.venda_ids ? caixa.venda_ids.length : 0}</p>
      `;
      listaCaixas.appendChild(item);
    });
  })
  .catch(err => {
    console.error("Erro ao carregar histórico:", err);
    listaCaixas.innerHTML = `<p>Erro ao carregar histórico de fechamentos.</p>`;
  });