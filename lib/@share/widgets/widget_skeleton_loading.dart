import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

Widget skeletonLoading(BuildContext context) => Column(
      children: [
        skeleton(context),
        skeleton(context),
        skeleton(context),
        skeleton(context),
      ],
    );

Widget skeleton(BuildContext context) => SkeletonItem(
      child: Container(
        margin: const EdgeInsets.fromLTRB(5, 15, 5, 15),
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  shape: BoxShape.circle, width: 53, height: 53),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SkeletonParagraph(
                style: SkeletonParagraphStyle(
                    lines: 2,
                    spacing: 10,
                    lineStyle: SkeletonLineStyle(
                      randomLength: true,
                      height: 10,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width / 2,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
