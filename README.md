# Ecommerce App

#### Se creo esta Aplicación siguiendo este [diseño.](https://dribbble.com/shots/22831990-Ecommerce-App-Concept)

### Descripción
Este proyecto es una aplicación de e-commerce desarrollada utilizando Flutter. La aplicación permite a los usuarios explorar un catálogo de productos y agregar artículos a su carrito. La arquitectura de la aplicación se basa en el patrón BLoC (Business Logic Component) para gestionar el estado de la aplicación de manera eficiente y en MVVM (Model-View-ViewModel) para una clara separación de las responsabilidades.

### Características
- **Gestión de Estado con BLoC:** La aplicación utiliza BLoC para gestionar el estado de manera eficiente. Los módulos clave de la aplicación, como `EcommerceBloc`, `EcommerceState`, y `EcommerceEvent`, manejan eventos y estados específicos de cada funcionalidad.
- **Patrón MVVM:** Utilizamos el patrón MVVM para estructurar el proyecto, con la lógica de negocio separada en ViewModels y la representación visual en Views, facilitando la mantenibilidad y escalabilidad del código.
- **Integración con API:** La aplicación se conecta a una API externa utilizando Dio para obtener los datos de los productos y actualizaciones en tiempo real.
- **Interfaz de Usuario Amigable:** La UI está diseñada con Flutter, proporcionando una experiencia de usuario fluida y moderna. Utilizamos widgets personalizados como `AppPrimaryButton` y `ProductWidget` para asegurar una estética consistente.
- **Funcionalidades Completas de E-commerce:** Los usuarios pueden navegar por el catálogo de productos, ver detalles de cada producto, agregar productos al carrito y proceder al proceso de compra.

### Estructura del Proyecto
El proyecto está organizado de la siguiente manera:

```
lib/
  ├── bloc/
  │   ├── ecommerce_bloc.dart
  │   ├── ecommerce_event.dart
  │   ├── ecommerce_state.dart
  ├── models/
  │   ├── data.dart
  │   └── product_model.dart
  ├── viewmodels/
  │   ├── cart_viewmodel.dart
  │   ├── catalog_viewmodel.dart
  │   └── product_viewmodel.dart
  ├── views/
  │   ├── add_product_view.dart
  │   ├── cart_view.dart
  │   ├── catalog_view.dart
  │   ├── home_view.dart
  │   ├── main_view.dart
  │   └── product_view.dart
  ├── utils/
  │   └── app_colors.dart
  ├── widgets/
  │   ├── app_primary_button.dart
  │   ├── bottom_menu_item.dart
  │   ├── cart_item.dart
  │   ├── categories_widget.dart
  │   ├── product_form.dart
  │   └── products_widget.dart
  └── main.dart
```


### Tecnologías Utilizadas
- **Flutter:** Framework principal utilizado para el desarrollo de la aplicación.
- **Dio:** Librería para realizar solicitudes HTTP.
- **BLoC:** Gestión del estado con el patrón BLoC.
- **MVVM:** Arquitectura basada en el patrón MVVM.
- **Firebase:** Utiliza Firebase Realtime Database para la gestión de datos en tiempo real.




