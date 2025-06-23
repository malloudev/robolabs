import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visual Code Editor',
      theme: ThemeData(
        brightness: Brightness.dark, // Explicitly set to dark mode
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark, // Ensure ColorScheme also aligns with dark brightness
        ).copyWith(
          secondary: Colors.deepPurple,
        ),
        extensions: <ThemeExtension<dynamic>>[
          const CodeBlockColors(
            variableBg: Color(0xFF1A237E), // Darker Blue
            variableBorder: Color(0xFF3F51B5), // Dark Blue
            functionBg: Color(0xFF1B5E20), // Darker Green
            functionBorder: Color(0xFF4CAF50), // Dark Green
            loopBg: Color(0xFFF57F17), // Darker Orange
            loopBorder: Color(0xFFFFC107), // Dark Orange
            conditionBg: Color(0xFF4A148C), // Darker Purple
            conditionBorder: Color(0xFF9C27B0), // Dark Purple
            printBg: Color(0xFFB71C1C), // Darker Red
            printBorder: Color(0xFFE53935), // Dark Red
          ),
        ],
      ),
      home: const Index(),
    );
  }
}

class CodeBlockColors extends ThemeExtension<CodeBlockColors> {
  const CodeBlockColors({
    required this.variableBg, required this.variableBorder,
    required this.functionBg, required this.functionBorder,
    required this.loopBg, required this.loopBorder,
    required this.conditionBg, required this.conditionBorder,
    required this.printBg, required this.printBorder,
  });

  final Color variableBg;
  final Color variableBorder;
  final Color functionBg;
  final Color functionBorder;
  final Color loopBg;
  final Color loopBorder;
  final Color conditionBg;
  final Color conditionBorder;
  final Color printBg;
  final Color printBorder;

  @override
  CodeBlockColors copyWith({
    Color? variableBg, Color? variableBorder,
    Color? functionBg, Color? functionBorder,
    Color? loopBg, Color? loopBorder,
    Color? conditionBg, Color? conditionBorder,
    Color? printBg, Color? printBorder,
  }) {
    return CodeBlockColors(
      variableBg: variableBg ?? this.variableBg,
      variableBorder: variableBorder ?? this.variableBorder,
      functionBg: functionBg ?? this.functionBg,
      functionBorder: functionBorder ?? this.functionBorder,
      loopBg: loopBg ?? this.loopBg,
      loopBorder: loopBorder ?? this.loopBorder,
      conditionBg: conditionBg ?? this.conditionBg,
      conditionBorder: conditionBorder ?? this.conditionBorder,
      printBg: printBg ?? this.printBg,
      printBorder: printBorder ?? this.printBorder,
    );
  }

  @override
  ThemeExtension<CodeBlockColors> lerp(covariant ThemeExtension<CodeBlockColors>? other, double t) {
    if (other is! CodeBlockColors) {
      return this;
    }
    return CodeBlockColors(
      variableBg: Color.lerp(variableBg, other.variableBg, t)!,
      variableBorder: Color.lerp(variableBorder, other.variableBorder, t)!,
      functionBg: Color.lerp(functionBg, other.functionBg, t)!,
      functionBorder: Color.lerp(functionBorder, other.functionBorder, t)!,
      loopBg: Color.lerp(loopBg, other.loopBg, t)!,
      loopBorder: Color.lerp(loopBorder, other.loopBorder, t)!,
      conditionBg: Color.lerp(conditionBg, other.conditionBg, t)!,
      conditionBorder: Color.lerp(conditionBorder, other.conditionBorder, t)!,
      printBg: Color.lerp(printBg, other.printBg, t)!,
      printBorder: Color.lerp(printBorder, other.printBorder, t)!,
    );
  }
}

enum CodeBlockType {
  variable,
  function,
  loop,
  condition,
  print,
}

class CodeBlock {
  final String id;
  final CodeBlockType type;
  final String label;
  final String code;
  double x;
  double y;

  CodeBlock({
    required this.id,
    required this.type,
    required this.label,
    required this.code,
    this.x = 0.0,
    this.y = 0.0,
  });

  factory CodeBlock.fromTemplate(Map<String, dynamic> template, {double x = 0.0, double y = 0.0}) {
    return CodeBlock(
      id: const Uuid().v4(),
      type: template['type'] as CodeBlockType,
      label: template['label'] as String,
      code: template['code'] as String,
      x: x,
      y: y,
    );
  }
}

class TextEditor extends StatefulWidget {
  final String code;
  final ValueChanged<String> onChange;

  const TextEditor({
    super.key,
    required this.code,
    required this.onChange,
  });

  @override
  State<TextEditor> createState() => _TextEditorState();
}

class _TextEditorState extends State<TextEditor> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.code);
  }

  @override
  void didUpdateWidget(covariant TextEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.code != oldWidget.code) {
      _controller.text = widget.code;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _controller,
        onChanged: widget.onChange,
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: 'Your generated code will appear here, or write your own code...',
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface, // Uses theme's surface color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Colors.grey[700]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
          ),
          contentPadding: const EdgeInsets.all(12.0),
        ),
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 14.0,
          color: Theme.of(context).colorScheme.onSurface, // Text color adapts to surface
        ),
        keyboardType: TextInputType.multiline,
      ),
    );
  }
}

class DraggableBlock extends StatefulWidget {
  final CodeBlock block;
  final Function(String id, double x, double y) onPositionChange;
  final Function(String id) onDelete;

  const DraggableBlock({
    super.key,
    required this.block,
    required this.onPositionChange,
    required this.onDelete,
  });

  @override
  State<DraggableBlock> createState() => _DraggableBlockState();
}

class _DraggableBlockState extends State<DraggableBlock> {
  late double _currentX;
  late double _currentY;
  bool _isDragging = false;
  Offset _dragOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _currentX = widget.block.x;
    _currentY = widget.block.y;
  }

  @override
  void didUpdateWidget(covariant DraggableBlock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.block.x != oldWidget.block.x || widget.block.y != oldWidget.block.y) {
      _currentX = widget.block.x;
      _currentY = widget.block.y;
    }
  }

  void _handlePanStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      _dragOffset = renderBox.globalToLocal(details.globalPosition);
    });
  }

  void _handlePanUpdate(DragUpdateDetails details) {
    setState(() {
      final RenderBox parentRenderBox = context.findRenderObject()!.parent as RenderBox;
      final Offset parentOffset = parentRenderBox.localToGlobal(Offset.zero);

      double newX = details.globalPosition.dx - parentOffset.dx - _dragOffset.dx;
      double newY = details.globalPosition.dy - parentOffset.dy - _dragOffset.dy;

      _currentX = newX.clamp(0.0, double.infinity);
      _currentY = newY.clamp(0.0, double.infinity);

      widget.onPositionChange(widget.block.id, _currentX, _currentY);
    });
  }

  void _handlePanEnd(DragEndDetails details) {
    setState(() {
      _isDragging = false;
    });
  }

  Map<String, Color> _getBlockColors(CodeBlockType type) {
    final blockColorsExtension = Theme.of(context).extension<CodeBlockColors>()!;
    switch (type) {
      case CodeBlockType.variable:
        return {'bg': blockColorsExtension.variableBg, 'border': blockColorsExtension.variableBorder};
      case CodeBlockType.function:
        return {'bg': blockColorsExtension.functionBg, 'border': blockColorsExtension.functionBorder};
      case CodeBlockType.loop:
        return {'bg': blockColorsExtension.loopBg, 'border': blockColorsExtension.loopBorder};
      case CodeBlockType.condition:
        return {'bg': blockColorsExtension.conditionBg, 'border': blockColorsExtension.conditionBorder};
      case CodeBlockType.print:
        return {'bg': blockColorsExtension.printBg, 'border': blockColorsExtension.printBorder};
      default:
        return {'bg': Colors.grey[800]!, 'border': Colors.grey[600]!}; // Fallback for dark mode
    }
  }

  @override
  Widget build(BuildContext context) {
    final blockColors = _getBlockColors(widget.block.type);

    return Positioned(
      left: _currentX,
      top: _currentY,
      child: GestureDetector(
        onPanStart: _handlePanStart,
        onPanUpdate: _handlePanUpdate,
        onPanEnd: _handlePanEnd,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.9,
            minWidth: 150,
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut,
            decoration: BoxDecoration(
              color: blockColors['bg'],
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: blockColors['border']!, width: 2),
              boxShadow: [
                if (_isDragging)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                else
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
              ],
            ),
            transform: _isDragging ? (Matrix4.identity()..scale(1.05)) : Matrix4.identity(),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            widget.block.label,
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, size: 12),
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7), // Adapts to theme
                          onPressed: () {
                            widget.onDelete(widget.block.id);
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          splashRadius: 15,
                          highlightColor: Colors.red.withOpacity(0.1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5), // Using surfaceVariant for code background
                        borderRadius: BorderRadius.circular(4.0),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Text(
                        widget.block.code,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'monospace',
                          color: Theme.of(context).colorScheme.onSurfaceVariant, // Text color adapts
                        ),
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CodeCanvas extends StatefulWidget {
  final List<CodeBlock> blocks;
  final ValueChanged<List<CodeBlock>> setBlocks;

  const CodeCanvas({
    super.key,
    required this.blocks,
    required this.setBlocks,
  });

  @override
  State<CodeCanvas> createState() => _CodeCanvasState();
}

class _CodeCanvasState extends State<CodeCanvas> {
  final GlobalKey _canvasKey = GlobalKey();

  void updateBlockPosition(String id, double x, double y) {
    final updatedBlocks = widget.blocks.map((block) {
      if (block.id == id) {
        return CodeBlock(
          id: block.id,
          type: block.type,
          label: block.label,
          code: block.code,
          x: x,
          y: y,
        );
      }
      return block;
    }).toList();
    widget.setBlocks(updatedBlocks);
  }

  void deleteBlock(String id) {
    widget.setBlocks(widget.blocks.where((block) => block.id != id).toList());
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<Map<String, dynamic>>(
      onAcceptWithDetails: (DragTargetDetails<Map<String, dynamic>> details) {
        final RenderBox renderBox = _canvasKey.currentContext!.findRenderObject() as RenderBox;
        final Offset localOffset = renderBox.globalToLocal(details.offset);

        final CodeBlock newBlock = CodeBlock.fromTemplate(
          details.data,
          x: localOffset.dx,
          y: localOffset.dy,
        );

        widget.setBlocks([...widget.blocks, newBlock]);
      },
      builder: (context, candidateData, rejectedData) {
        return Container(
          key: _canvasKey,
          color: Theme.of(context).colorScheme.background, // Canvas background adapts to theme
          child: Stack(
            children: [
              if (widget.blocks.isEmpty)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Drag blocks here to start coding',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), // Text color adapts
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Use the drawer on the left to add code blocks',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.5), // Text color adapts
                        ),
                      ),
                    ],
                  ),
                ),
              ...widget.blocks.map((block) =>
                  DraggableBlock(
                    key: ValueKey(block.id),
                    block: block,
                    onPositionChange: updateBlockPosition,
                    onDelete: deleteBlock,
                  ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CodeBlockDrawer extends StatefulWidget {
  const CodeBlockDrawer({super.key});

  @override
  State<CodeBlockDrawer> createState() => _CodeBlockDrawerState();
}

class _CodeBlockDrawerState extends State<CodeBlockDrawer> {
  bool isCollapsed = false;

  final List<Map<String, dynamic>> codeBlockTemplates = const [
    {
      'type': CodeBlockType.variable,
      'label': 'Variable',
      'code': 'let variable = "value";',
    },
    {
      'type': CodeBlockType.function,
      'label': 'Function',
      'code': 'function myFunction() {\n  // code here\n}',
    },
    {
      'type': CodeBlockType.loop,
      'label': 'For Loop',
      'code': 'for (let i = 0; i < 10; i++) {\n  // code here\n}',
    },
    {
      'type': CodeBlockType.condition,
      'label': 'If Statement',
      'code': 'if (condition) {\n  // code here\n}',
    },
    {
      'type': CodeBlockType.print,
      'label': 'Console Log',
      'code': 'console.log("Hello World");',
    }
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      width: isCollapsed ? 48.0 : 256.0,
      decoration: BoxDecoration(
        color: colorScheme.surface, // Drawer background adapts to theme
        border: Border(right: BorderSide(color: colorScheme.outline.withOpacity(0.3))),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colorScheme.outline.withOpacity(0.3))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (!isCollapsed)
                  Text(
                    'Code Blocks',
                    style: TextStyle(fontWeight: FontWeight.w600, color: colorScheme.onSurface), // Text color adapts
                  ),
                IconButton(
                  icon: Icon(isCollapsed ? Icons.chevron_right : Icons.chevron_left, size: 16, color: colorScheme.onSurface), // Icon color adapts
                  onPressed: () {
                    setState(() {
                      isCollapsed = !isCollapsed;
                    });
                  },
                  splashRadius: 20,
                ),
              ],
            ),
          ),
          if (!isCollapsed)
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: codeBlockTemplates.length,
                itemBuilder: (context, index) {
                  final template = codeBlockTemplates[index];
                  return Draggable<Map<String, dynamic>>(
                    data: template,
                    feedback: Material(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: colorScheme.primary.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          template['label'] as String,
                          style: TextStyle(color: colorScheme.onPrimary),
                        ),
                      ),
                    ),
                    childWhenDragging: Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant.withOpacity(0.3), // Adapts to theme
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: colorScheme.outline.withOpacity(0.5)), // Adapts to theme
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            template['label'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: colorScheme.onSurfaceVariant.withOpacity(0.7), // Adapts to theme
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${(template['code'] as String).split('\n')[0]}...',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: colorScheme.onSurfaceVariant.withOpacity(0.5), // Adapts to theme
                              fontFamily: 'monospace',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: colorScheme.primary.withOpacity(0.2)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            template['label'] as String,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.0,
                              color: colorScheme.onSurface, // Adapts to theme
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${(template['code'] as String).split('\n')[0]}...',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: colorScheme.onSurface.withOpacity(0.7), // Adapts to theme
                              fontFamily: 'monospace',
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  bool isTextMode = false;
  List<CodeBlock> blocks = [];
  String generatedCode = '';

  void generateCode() {
    blocks.sort((a, b) => (a.y).compareTo(b.y));
    setState(() {
      generatedCode = blocks.map((block) => block.code).join('\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Row(
        children: [
          const CodeBlockDrawer(),
          Expanded(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: colorScheme.outline.withOpacity(0.3))), // Adapts to theme
                    color: colorScheme.surface, // Top bar background adapts to theme
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Visual Code Editor',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface, // Text color adapts
                        ),
                      ),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            style: isTextMode
                                ? ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary, // Active button is primary
                              foregroundColor: colorScheme.onPrimary, // Text on primary
                            )
                                : ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.surface, // Inactive button is surface
                              foregroundColor: colorScheme.onSurface, // Text on surface
                              side: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                            ),
                            onPressed: () {
                              setState(() {
                                isTextMode = false;
                              });
                            },
                            icon: const Icon(Icons.remove_red_eye_outlined, size: 16),
                            label: const Text('Visual'),
                          ),
                          ElevatedButton.icon(
                            style: isTextMode
                                ? ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.primary, // Active button is primary
                              foregroundColor: colorScheme.onPrimary, // Text on primary
                            )
                                : ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.surface, // Inactive button is surface
                              foregroundColor: colorScheme.onSurface, // Text on surface
                              side: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
                            ),
                            onPressed: () {
                              setState(() {
                                isTextMode = true;
                                generateCode();
                              });
                            },
                            icon: const Icon(Icons.code, size: 16),
                            label: const Text('Text'),
                          ),
                          ElevatedButton(
                            onPressed: generateCode,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: colorScheme.secondaryContainer,
                              foregroundColor: colorScheme.onSecondaryContainer,
                            ),
                            child: const Text('Generate Code'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: isTextMode
                      ? TextEditor(
                    code: generatedCode,
                    onChange: (value) {
                      setState(() {
                        generatedCode = value;
                      });
                    },
                  )
                      : CodeCanvas(
                    blocks: blocks,
                    setBlocks: (newBlocks) {
                      setState(() {
                        blocks = newBlocks;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
