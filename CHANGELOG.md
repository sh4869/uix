# 0.7.1
- Fixed issue in updating implicit children.

# 0.7.0

- Added support for namespaced attributes.
- Changed interface to specify attributes for virtual
  nodes. `vElement('div', attrs: {Attr.id: 'myId'})`. `Attr` class
  contains all attributes.
- Added `customAttrs` property to virtual nodes to specify custom
  attributes like `data-myattr`.
- Changed interface to specify styles for virtual
  nodes. `vElement('div', style: {Style.top: '10px'})`. `Style` class
  contains all styles.
- **EXPERIMENTAL** support for moving html nodes and Components
  between different parents with `Anchor` objects.
- Added `props` property to virtual nodes to specify element
  properties. `Prop` class contains all properties.
- Adjacent text nodes separated by comments `<---->` when rendered to
  string. And comment nodes ignored when virtual nodes mounted on top
  of existing html.

# 0.6.0

- Basic form components moved to
  [uix_forms](https://github.com/localvoid/uix_forms) package.
- CSS Transition Container moved to
  [uix_css_transition_container](https://github.com/localvoid/uix_css_transition_container)
  package.

# 0.5.2

- Attributes in VNodes can accept `num` and `bool` types for values
  and will be automatically converted to `Strings`. `bool` type will
  work as html
  [boolean attribute](https://html.spec.whatwg.org/multipage/infrastructure.html#boolean-attributes).
- Attributes and styles in VNodes can accept `null` values. Attributes
  and styles with `null` value will be removed from the dom element.

# 0.5.1

- Virtual Nodes for Components are no longer responsible for calling
  `Component.update()` method, and now they're just creating
  components and passing new data.
- `inject*` helper methods are no longer calling `Component.update()`
  method.
- If `Component.invalidate()` method is called when Scheduler is
  running tasks for the currentFrame, Component is registered to the
  `currentFrame` write task queue, otherwise to the `nextFrame`.
- `Component.invalidate()` will register Component in the Scheduler
  only when it has `shouldUpdateViewFlags`.
- When Component is attached to the document, component will be
  invalidated.
- Added new stream `onNextFrame` to the Scheduler.

# 0.5.0

- Fixed wrong sort order for `Scheduler` write tasks.
- Fixed bug with clearing wrong flag for nextTick tasks.
- Removed build step: `ComponentGenerator` and `source_gen`
  dependency.

# 0.4.0

- `createClassName` and `vClassName` auto-generated functions removed.
  Creating Components is now possible with simple `new ClassName()` and
  to create virtual nodes that represent components
  `vComponent($ClassName, ...)`. When metaclasses are implemented in
  Dart, build step will be completely removed, and it will be possible to
  create virtual nodes with `vComponent(ClassName, ...)`. And it will be
  quite easy to migrate existing codebase just by removing `$` prefix
  in all `vComponent` calls.
- `resetTransientSubscriptions`, `resetSubscriptions` renamed to
  `cancelTransientSubscriptions` and `cancelSubscriptions`.
- Added `type` property check when looking for similar virtual nodes.
