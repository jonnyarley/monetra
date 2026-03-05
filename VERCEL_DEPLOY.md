# 🚀 Deploy Monetra na Vercel

## Passo a Passo Completo

### 1. Criar Conta na Vercel
- Acesse: https://vercel.com
- Clique em "Sign Up"
- Escolha "Continue with GitHub"
- Autorize a Vercel a acessar seus repositórios

### 2. Importar o Projeto
1. No dashboard da Vercel, clique em **"Add New..."** → **"Project"**
2. Selecione o repositório **`jonnyarley/monetra`**
3. Clique em **"Import"**

### 3. Configurar o Projeto
A Vercel vai detectar automaticamente que é Next.js. Mantenha as configurações padrão:

- **Framework Preset**: Next.js
- **Root Directory**: `./`
- **Build Command**: `next build` (automático)
- **Output Directory**: `.next` (automático)
- **Install Command**: `bun install` (automático)

### 4. Configurar Variáveis de Ambiente

Antes de clicar em Deploy, adicione as variáveis de ambiente:

#### 4.1 Banco de Dados PostgreSQL

**Opção A: Vercel Postgres (Recomendado)**
1. No projeto, vá em **"Storage"**
2. Clique em **"Create Database"**
3. Escolha **"Postgres"**
4. Dê o nome: `monetra-db`
5. Selecione a região: `Washington, D.C., USA` ou `São Paulo, Brazil`
6. Clique em **"Create"**
7. A Vercel vai adicionar automaticamente a `DATABASE_URL`

**Opção B: Neon (Gratuito)**
1. Acesse: https://neon.tech
2. Crie uma conta gratuita
3. Crie um projeto: "monetra"
4. Copie a connection string
5. Adicione no Vercel como `DATABASE_URL`

**Opção C: Supabase (Gratuito)**
1. Acesse: https://supabase.com
2. Crie um projeto
3. Vá em Settings → Database
4. Copie a URI do PostgreSQL
5. Adicione no Vercel como `DATABASE_URL`

#### 4.2 Variáveis Obrigatórias

Adicione estas variáveis em **Settings** → **Environment Variables**:

| Nome | Valor | Ambiente |
|------|-------|----------|
| `NEXTAUTH_SECRET` | (gere com: `openssl rand -base64 32`) | Production |
| `NEXTAUTH_URL` | `https://seu-app.vercel.app` | Production |
| `ADMIN_PASSWORD` | `sua-senha-admin-segura` | Production |
| `JWT_SECRET` | (gere com: `openssl rand -base64 32`) | Production |

#### 4.3 Gerar Secrets

Você pode gerar os secrets no terminal:
```bash
openssl rand -base64 32
```

Ou usar um gerador online: https://generate-random.org/encryption-key-generator

### 5. Deploy!

1. Clique em **"Deploy"**
2. Aguarde o build (geralmente 2-3 minutos)
3. Quando aparecer 🎉, seu app está no ar!

### 6. Configurar Banco de Dados (Pós-Deploy)

Após o primeiro deploy, você precisa criar as tabelas:

**Opção A: Via Vercel CLI**
```bash
# Instalar Vercel CLI
npm i -g vercel

# Login
vercel login

# Link do projeto
vercel link

# Executar migração
vercel env pull .env.production
npx prisma migrate deploy
```

**Opção B: Via Prisma Studio (local conectado ao banco remoto)**
```bash
# Baixe o .env do Vercel
# Execute localmente:
DATABASE_URL="sua-url-do-postgres" npx prisma db push
```

**Opção C: Adicionar script de migração no Vercel**

Adicione uma variável de ambiente:
- Nome: `PRISMA_MIGRATE`
- Valor: `true`

E adicione no script de build.

### 7. Domínio Personalizado (Opcional)

1. Vá em **Settings** → **Domains**
2. Adicione seu domínio (ex: `monetra.com.br`)
3. Configure os DNS conforme instruído

---

## 🔧 Variáveis de Ambiente Completas

```env
# Banco de Dados (PostgreSQL)
DATABASE_URL="postgresql://user:password@host:5432/monetra?sslmode=require"

# Autenticação
NEXTAUTH_SECRET="seu-secret-muito-seguro-aqui"
NEXTAUTH_URL="https://seu-app.vercel.app"

# Admin
ADMIN_PASSWORD="sua-senha-admin"
JWT_SECRET="seu-jwt-secret-aqui"

# OAuth (opcional)
GOOGLE_CLIENT_ID="xxx"
GOOGLE_CLIENT_SECRET="xxx"

# Stripe (opcional)
STRIPE_SECRET_KEY="sk_xxx"
STRIPE_WEBHOOK_SECRET="whsec_xxx"
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY="pk_xxx"
```

---

## ❓ Problemas Comuns

### Erro: "Prisma Client could not be generated"
- Verifique se `DATABASE_URL` está correto
- Execute `npx prisma generate` localmente e faça push

### Erro: "Database connection failed"
- Verifique se o banco PostgreSQL está acessível
- Confirme se a região do banco é a mesma do app

### Erro: "NEXTAUTH_SECRET is required"
- Adicione a variável `NEXTAUTH_SECRET` nas environment variables

---

## 📱 Próximos Passos

1. ✅ Deploy realizado
2. ✅ Banco configurado
3. ✅ Criar conta de admin
4. 📱 Publicar app Android/iOS
5. 💳 Configurar pagamentos (Stripe/Google Play)

---

**Precisa de ajuda?** Me chama! 🚀
