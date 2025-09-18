# VendorsFinder

iOS test project built with **SwiftUI + MVVM**.  
The app displays a list of vendors with support for:

- 🔍 Search with debounce (0.5s, starts from 3 characters)
- 📜 Infinite scrolling with mocked pagination
- ❤️ Favorite state indicator
- 🖼️ Images loading via Kingfisher
- 🗂️ Modular project structure (Repository + ViewModel + Views)

## Networking

- The network layer is prepared for integration with a real API (`URLSession` + `Endpoint`).
- Currently uses `VendorsRepositoryMock`, which:
  - Reads vendors from `vendors.json` or `vendorsExtended.json` (based on your choose, `vendors.json` by default)
  - Emulates server-side filtering and pagination
  - Simulates latency to show loading states

---

**Note:** This is a test assignment project. Some parts (e.g. API integration) are mocked but the architecture is ready for production use
