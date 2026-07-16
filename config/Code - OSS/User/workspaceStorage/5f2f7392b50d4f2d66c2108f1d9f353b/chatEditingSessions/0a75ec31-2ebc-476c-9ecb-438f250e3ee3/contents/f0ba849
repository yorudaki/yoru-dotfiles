const listaCaixas = document.getElementById("lista-caixas");

// Fetch caixas and vendas to show products inside each caixa
Promise.all([
  fetch("http://localhost:3000/caixas").then(r => r.json()),
  fetch("http://localhost:3000/vendas").then(r => r.json())
])
  .then(([caixas, vendas]) => {
    if (!caixas || caixas.length === 0) {
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

      // gather vendas for this caixa
      const vendaIds = caixa.venda_ids || [];
      const vendasDaCaixa = vendas.filter(v => vendaIds.includes(v.id));

      // aggregate items across vendasDaCaixa
      const itemsAgg = {};
      vendasDaCaixa.forEach(venda => {
        (venda.itens || []).forEach(it => {
          const nome = it.nome_produto || it.id_produto || 'Item';
          itemsAgg[nome] = (itemsAgg[nome] || 0) + (it.quantidade || 0);
        });
      });

      let itensHTML = '';
      if (Object.keys(itemsAgg).length === 0) {
        itensHTML = '<li>Nenhum item vinculado a este fechamento.</li>';
      } else {
        Object.entries(itemsAgg).forEach(([nome, qtd]) => {
          itensHTML += `<li>x${qtd} ${nome}</li>`;
        });
      }

      const item = document.createElement("div");
      item.className = "caixa-item";
      item.innerHTML = `
        <div class="caixa-meta">
          <p class="caixa-data"><strong>Data:</strong> ${dataFormatada} ${horaFormatada}</p>
          <div class="caixa-actions">
            <p class="caixa-total">Total R$ ${caixa.total.toFixed(2)}</p>
            <button class="btn-dropdown" data-caixa-id="${caixa.id}">Detalhes ▾</button>
          </div>
        </div>
        <div class="caixa-vendas-list" id="caixa-vendas-${caixa.id}" hidden>
          <ul>
            ${itensHTML}
          </ul>
        </div>
      `;

      listaCaixas.appendChild(item);

      // attach toggle listener
      const btn = item.querySelector('.btn-dropdown');
      const list = item.querySelector(`#caixa-vendas-${caixa.id}`);
      btn.addEventListener('click', () => {
        const isHidden = list.hasAttribute('hidden');
        if (isHidden) {
          list.removeAttribute('hidden');
          btn.innerText = 'Detalhes ▴';
        } else {
          list.setAttribute('hidden', '');
          btn.innerText = 'Detalhes ▾';
        }
      });
    });
  })
  .catch(err => {
    console.error("Erro ao carregar histórico:", err);
    listaCaixas.innerHTML = `<p>Erro ao carregar histórico de fechamentos.</p>`;
  });