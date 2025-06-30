# Tractian Challenge - Mobile Software Engineer

Este projeto é uma resposta ao desafio **Mobile Software Engineer** da Tractian, desenvolvido em Flutter.

## 📋 Contexto

Os ativos são essenciais para a operação da indústria, podendo incluir desde equipamentos de fabricação até veículos de transporte e sistemas de geração de energia. O gerenciamento e manutenção adequados são cruciais para garantir que continuem operando de forma eficiente e eficaz. Uma maneira prática de visualizar a hierarquia de ativos é através de uma estrutura em árvore.

## 🎯 Desafio

**Construir uma aplicação Tree View que mostra os ativos das empresas** (A árvore é basicamente composta por componentes, ativos e localizações)

### Componentes
- São as partes que constituem um ativo
- Podem estar associados a um ativo ou localização como pai
- Incluem sensores de vibração ou energia
- Possuem status operacional ou de alerta
- Ícone: `component`

### Ativos/Sub-Ativos
- Possuem um conjunto de componentes
- Podem conter N sub-ativos
- Geralmente associados a uma localização
- Ícone: `asset`

### Localizações/Sub-Localizações
- Representam os lugares onde os ativos estão localizados
- Podem conter N sub-localizações para melhor organização
- Ícone: `location`

## 🚀 Funcionalidades

### 1. Página Inicial
Menu para navegar entre diferentes empresas e acessar seus ativos.

### 2. Página de Ativos
Visualização em árvore da hierarquia de ativos da empresa.

**Sub-funcionalidades:**
- **Visualização Dinâmica**: Estrutura em árvore apresentando componentes, ativos e localizações
- **Filtros**:
  - Busca por texto
  - Sensores de energia
  - Status crítico de sensores

## 🏗️ Arquitetura

O projeto implementa uma arquitetura **MVVM (Model-View-ViewModel)** combinada com **State Pattern** para gerenciamento de estado reativo.

### Estrutura de Pastas

```
lib/
├── core/
│   ├── data/
│   │   ├── datasource/     # Fontes de dados (API)
│   │   └── repositorie/    # Implementação dos repositórios
│   └── domain/
│       ├── entities/       # Entidades de domínio
│       └── usecases/       # Casos de uso
├── features/
│   ├── assets_list/        # Funcionalidade principal da árvore
│   ├── home/              # Página inicial
│   └── splash/            # Splash screen
├── helpers/
│   ├── base_notifier.dart  # State Pattern implementation
│   ├── injections.dart     # Injeção de dependência
│   └── navigation.dart     # Navegação
└── utils/                  # Utilitários e constantes
```

### Padrões Implementados

#### 1. **MVVM Pattern**
- **Model**: Entidades de domínio e lógica de negócio
- **View**: Componentes visuais (Widgets)
- **ViewModel**: Gerenciamento de estado e lógica de apresentação

#### 2. **State Pattern**
```dart
class BaseNotifier<T> extends ValueNotifier<T> {
  void emit(T value) {
    if (hasListeners) {
      super.value = value;
    }
  }
}
```

#### 3. **Clean Architecture**
- Separação clara entre camadas
- Injeção de dependência com GetIt
- Casos de uso para lógica de negócio

## 🛠️ Tecnologias Utilizadas

### Flutter SDK
- **Versão**: ^3.7.2

### Principais Dependências
- **`get_it: ^8.0.3`** - Injeção de dependência
- **`flutter_svg: ^2.2.0`** - Renderização de ícones SVG
- **`dio: ^5.8.0+1`** - Cliente HTTP para consumo da API
- **`shimmer_animation: ^2.1.0+1`** - Animações de loading

## 📊 API Utilizada

### Endpoints
- `GET /companies` - Retorna todas as empresas
- `GET /companies/:companyId/locations` - Retorna localizações da empresa
- `GET /companies/:companyId/assets` - Retorna ativos da empresa

## 🎨 Particularidades da Implementação

### 1. **Tree Builder Customizado**
Implementação própria para construção da árvore hierárquica, otimizada para performance com grandes datasets.

### 2. **Filtragem Inteligente**
Sistema de filtros que mantém o caminho completo dos ativos, garantindo que os usuários sempre vejam a hierarquia completa.

### 3. **Gerenciamento de Estado Reativo**
Utilização do padrão State com ValueNotifier para atualizações eficientes da UI.

### 4. **Injeção de Dependência**
Configuração robusta com GetIt para desacoplamento e testabilidade.


## 📱 Compatibilidade

- **iOS**: 12.0+
- **Android**: API 21+
- **Flutter**: 3.7.2+

## 🤝 Contribuição

Este projeto foi desenvolvido como resposta a um desafio técnico. Sugestões e melhorias são sempre bem-vindas!

---

**Desenvolvedor**: Patrick Alvares

