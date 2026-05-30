const express = require('express');
const app = express();
const fs = require('fs');
const path = require('path');

app.use(express.json());

function getDb() {
  const data = fs.readFileSync(path.join(__dirname, 'db.json'), 'utf8');
  return JSON.parse(data);
}

app.post('/auth/login', (req, res) => {
  const { usuario, senha } = req.body;
  const db = getDb();

  const user = db.usuarios.find(
    (u) => u.usuario === usuario && u.senha === senha
  );

  if (user) {
    const token = `token_fake_${user.id}_${Date.now()}`;
    res.json({ token, usuario: user.usuario });
  } else {
    res.status(401).json({ error: 'Usuário ou senha inválidos' });
  }
});

app.get('/produtos', (req, res) => {
  const db = getDb();
  res.json(db.produtos);
});

app.get('/carrinho', (req, res) => {
  const db = getDb();
  res.json(db.carrinho);
});

app.listen(3000, () => {
  console.log('✅ Servidor rodando em http://localhost:3000');
});