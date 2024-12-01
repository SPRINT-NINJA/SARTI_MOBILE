import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SlideInfo {
  final String title;
  final String description;
  final String image;

  SlideInfo({
    required this.title,
    required this.description,
    required this.image,
  });
}

const path = 'assets/images/tutorial';

final slides = <SlideInfo>[
  SlideInfo(
    title: 'Bienvenido a Sarti',
    description:
        'Sarti es una aplicación que te permite comprar productos de calidad y recibirlos en la puerta de tu casa.',
    image: '$path/1.png',
  ),
  SlideInfo(
    title: 'Elige tus productos',
    description:
        'Explora nuestro catálogo y selecciona los productos que deseas comprar.',
    image: '$path/2.png',
  ),
  SlideInfo(
    title: 'Recibe tus productos',
    description:
        'Recibe tus productos en la puerta de tu casa y disfruta de la calidad de Sarti.',
    image: '$path/3.png',
  ),
];

class TutorialView extends StatefulWidget {
  const TutorialView({super.key});

  static const name = 'tutorial';

  @override
  State<TutorialView> createState() => _TutorialViewState();
}

class _TutorialViewState extends State<TutorialView> {
  final PageController _pageController = PageController();
  bool endReached = false;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      final page = _pageController.page ?? 0;
      if (!endReached && page >= slides.length - 1.5) {
        setState(() {
          endReached = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            physics: const BouncingScrollPhysics(),
            children: slides
                .map((slideData) => _Slide(
                      title: slideData.title,
                      description: slideData.description,
                      image: slideData.image,
                    ))
                .toList(),
          ),
          Positioned(
            right: 20,
            top: 50,
            child: TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Saltar'),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 30,
            child: endReached
                ? FadeInRight(
                    from: 15,
                    child: FilledButton(
                      onPressed: () => context.go('/'),
                      child: const Text('Empezar'),
                    ),
                  )
                : FilledButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Siguiente')),
          ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String title;
  final String description;
  final String image;

  const _Slide(
      {
      required this.title,
      required this.description,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    final descriptionStyle = Theme.of(context).textTheme.bodySmall;
    final theme = Theme.of(context);

    final size = MediaQuery.of(context).size;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,
                style: titleStyle?.copyWith(
                  fontSize: 40,
                  color: theme.primaryColor,
                  fontWeight: FontWeight.bold,
                )),
            Image(
              image: AssetImage(image),
              width: size.width * 0.8,
              height: size.height * 0.4,
            ),
            const SizedBox(height: 20),
            Text(description,
                style: descriptionStyle, textAlign: TextAlign.center),
          ],
        ));
  }
}
