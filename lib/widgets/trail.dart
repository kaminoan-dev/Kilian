import 'package:flutter/material.dart';
import 'package:kilian/models/trail.dart';
import 'package:kilian/widgets/painting.dart';
import 'package:kilian/widgets/theme.dart';

import './basic.dart';
import './model_extensions.dart';
import '../l10n/l10n.dart';
import '../view-models/trail.dart';

const Widget _kSpacingHorizontalIcon = const SizedBox(width: 3);
const Widget _kSpacingBetweenRow = const SizedBox(width: 8);

const Widget _kVerticalSpacing = const SizedBox(height: 5);

const double _kSegmentTileHeight = 75;
const double _kSegmentIndexIndicatorWidth = 25;

class TrailSummary extends StatefulWidget {
  const TrailSummary(this.trail, {this.action, super.key});

  final TrailViewModel trail;

  final Widget? action;

  @override
  State<TrailSummary> createState() => new _TrailSummaryState();
}

class _TrailSummaryState extends State<TrailSummary> {
  bool expanded = true;

  @override
  void initState() {
    super.initState();
    expanded = true;
  }

  @override
  Widget build(BuildContext context) {
    return expanded
        ? new Card(
            margin: const EdgeInsets.only(left: 1.5 * kMarginSize, right: 1.5 * kMarginSize, bottom: kMarginSize),
            shape: kRoundedBorder,
            clipBehavior: Clip.hardEdge,
            elevation: 3,
            child: new Padding(
              padding: kMarginAllDouble,
              child: new Column(
                children: [
                  _buildTitleText(context),
                  kSpacingVerticalDouble,
                  new Row(
                    children: [
                      new Expanded(flex: 4, child: _buildHdistWidget()),
                      _kSpacingBetweenRow,
                      new Expanded(flex: 4, child: _buildDaltWidget()),
                      _kSpacingBetweenRow,
                      new Expanded(flex: 5, child: _buildDurationWidget()),
                    ],
                  ),
                ],
              ),
            ),
          )
        : _buildCollapsedTitleText(context);
  }

  Widget _buildTitleText(BuildContext context) {
    return new Row(
      children: [
        new SizedBox(width: 24),
        new Expanded(
          child: new Text(
            context.l10n.trailSummaryTitle,
            style: const TextStyle(fontSize: 22, color: Colors.blueGrey),
            textAlign: TextAlign.center,
          ),
        ),
        _buildToggle(),
      ],
    );
  }

  Widget _buildCollapsedTitleText(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3 * kMarginSize),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Text(
            context.l10n.trailSummaryLabel,
            style: const TextStyle(fontSize: 16, color: Colors.blueGrey),
            textAlign: TextAlign.center,
          ),
          _buildToggle(),
        ],
      ),
    );
  }

  Widget _buildToggle() {
    return new GestureDetector(
      child: Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
      onTap: () {
        setState(() {
          expanded = !expanded;
        });
      },
    );
  }

  Widget _buildHdistWidget() {
    final double distance = widget.trail.distance;
    final double hdist = widget.trail.hdist;
    final String strDist =
        distance > 1000 ? '${(distance / 1000).toStringAsFixed(1)} km' : '${distance.toStringAsFixed(0)} m';
    final String strHdist = hdist > 1000 ? '${(hdist / 1000).toStringAsFixed(1)} km' : '${hdist.toStringAsFixed(0)} m';

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new Icon(Icons.arrow_outward, color: Colors.brown, size: 22),
            _kSpacingHorizontalIcon,
            new Text(
              strDist,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        const SizedBox(height: 8),
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            new Icon(Icons.start, color: Colors.blueGrey, size: 20),
            _kSpacingHorizontalIcon,
            new Text(
              strHdist,
              style: const TextStyle(fontSize: 18, color: Colors.black38),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDaltWidget() {
    final double dplus = widget.trail.dplus;
    final double dminus = widget.trail.dminus.abs();
    final String strDplus = '${dplus < 0.1 ? "0" : "+${dplus.toStringAsFixed(0)}"} m';
    final String strDminus = '${dminus < 0.1 ? "0" : "-${dminus.toStringAsFixed(0)}"} m';

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_upward, color: Colors.cyan, size: 22),
            _kSpacingHorizontalIcon,
            new Text(
              strDplus,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        const SizedBox(height: 8),
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_downward, color: Colors.cyan, size: 22),
            _kSpacingHorizontalIcon,
            new Text(
              strDminus,
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDurationWidget() {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.hiking, color: Colors.black, size: 26),
            _kSpacingHorizontalIcon,
            new Text(
              widget.trail.duration.toHumanString(),
              style: const TextStyle(fontSize: 20),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        const SizedBox(height: 8),
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.pause_circle, color: Colors.blueGrey, size: 22),
            _kSpacingHorizontalIcon,
            new Text(
              widget.trail.resting.toHumanString(),
              style: const TextStyle(fontSize: 20, color: Colors.black38),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ],
    );
  }
}

class DraggableTrailSegmentTile extends StatelessWidget {
  const DraggableTrailSegmentTile({
    required this.segment,
    required this.index,
    this.onPressed,
    super.key,
  });

  final TrailSegmentViewModel segment;

  final int index;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(builder: (_, constraints) {
      final Widget child = new TrailSegmentTile(
        segment: segment,
        index: index,
        onPressed: onPressed,
      );

      return new Stack(
        children: [
          child,
          new Positioned(
            left: 2,
            child: new Draggable(
              // Link the underlying element and the widget with a unique ID.
              key: new ValueKey(child.hashCode),
              childWhenDragging: new SizedBox(
                width: constraints.maxWidth,
                height: _kSegmentTileHeight,
                child: const ColoredBox(color: Colors.white38),
              ),
              maxSimultaneousDrags: 1,
              feedback: new SizedBox(width: constraints.maxWidth, child: child),
              data: index,
              child: const SizedBox(
                height: _kSegmentTileHeight,
                width: _kSegmentIndexIndicatorWidth,
                child: const ColoredBox(color: Colors.transparent),
              ),
            ),
          )
        ],
      );
    });
  }
}

class TrailSegmentTile extends StatelessWidget {
  const TrailSegmentTile({
    required this.segment,
    required this.index,
    this.onPressed,
    super.key,
  });

  final TrailSegmentViewModel segment;

  final int index;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return new SizedBox(
      height: _kSegmentTileHeight,
      child: new Card(
        margin: const EdgeInsets.all(2),
        shape: kRoundedBorder,
        clipBehavior: Clip.hardEdge,
        child: new Row(
          children: [
            new _SegmentIndexIndicator(index: index + 1),
            new Expanded(
              child: new _TrailSegmentInfo(segment, onPressed: onPressed),
            ),
          ],
        ),
      ),
    );
  }
}

class _SegmentIndexIndicator extends StatelessWidget {
  const _SegmentIndexIndicator({
    required this.index,
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return new ColoredBox(
      color: AppColors.secondary,
      child: new SizedBox(
        width: _kSegmentIndexIndicatorWidth,
        child: new Center(
          child: new Padding(
            padding: kMarginAll,
            child: new Text(
              index.toString(),
              style: const TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class _TrailSegmentInfo extends StatelessWidget {
  const _TrailSegmentInfo(this.segment, {this.onPressed, super.key});

  final TrailSegmentViewModel segment;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new Padding(
        padding: kMarginAll,
        child: new Row(
          children: [
            new Expanded(flex: 4, child: _buildHdistWidget()),
            _kSpacingBetweenRow,
            new Expanded(flex: 4, child: _buildDaltWidget()),
            _kSpacingBetweenRow,
            _buildMIDLevelWidget(),
            _kSpacingBetweenRow,
            _kSpacingBetweenRow,
            new Expanded(flex: 5, child: _buildDurationWidget()),
          ],
        ),
      ),
    );
  }

  Widget _buildHdistWidget() {
    final String strDist = segment.distance > 1000
        ? '${(segment.distance / 1000).toStringAsFixed(2)} km'
        : '${segment.distance.toStringAsFixed(0)} m';
    final String strHdist = segment.hdist > 1000
        ? '${(segment.hdist / 1000).toStringAsFixed(2)} km'
        : '${segment.hdist.toStringAsFixed(0)} m';

    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.arrow_outward, color: Colors.brown, size: 16),
            _kSpacingHorizontalIcon,
            new Text(
              strDist,
              style: const TextStyle(fontSize: 17),
              textAlign: TextAlign.end,
            ),
          ],
        ),
        _kVerticalSpacing,
        new Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.start, color: Colors.blueGrey, size: 16),
            _kSpacingHorizontalIcon,
            new Text(
              strHdist,
              style: const TextStyle(fontSize: 16, color: Colors.black38),
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDaltWidget() {
    final String str =
        '${segment.dalt.abs() < 0.1 ? "" : segment.dalt > 0 ? "+" : "-"}${segment.dalt.abs().toStringAsFixed(0)} m';
    return new Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (segment.dalt.abs() > 0.1)
          new Icon(segment.dalt > 0 ? Icons.arrow_upward : Icons.arrow_downward,
              color: Colors.cyan, size: 16),
        _kSpacingHorizontalIcon,
        new Text(
          str,
          style: const TextStyle(fontSize: 17),
        ),
      ],
    );
  }

  Widget _buildMIDLevelWidget() {
    const double radius = 12.5;
    return SizedBox(
      width: 2 * radius + 6,
      child: new Center(
        child: new DecoratedBox(
          decoration: new BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(radius)),
              border: Border.all(color: segment.mid.color)),
          child: new SizedBox.square(
            dimension: 2 * radius,
            child: new Center(
              child: new Text(
                segment.mid.toNumber().toString(),
                style: new TextStyle(
                    fontSize: 16,
                    color: segment.mid.color,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDurationWidget() {
    return new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(Icons.hiking, color: Colors.blueGrey, size: 16),
            _kSpacingHorizontalIcon,
            new Text(
              segment.duration.toHumanString(),
              style: const TextStyle(fontSize: 20),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ],
        ),
        _kVerticalSpacing,
        new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            const Icon(Icons.pause_circle, color: Colors.blueGrey, size: 16),
            _kSpacingHorizontalIcon,
            new Text(
              segment.resting.toHumanString(),
              style: const TextStyle(fontSize: 20, color: Colors.black38),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ],
    );
  }
}

class TrailSegmentTilesHeader extends StatelessWidget {
  const TrailSegmentTilesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: kMarginAll,
      child: new Row(
        children: [
          _buildIndexIcon(),
          new Expanded(
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: new Row(
                children: [
                  new Expanded(flex: 9, child: _buildHdistWidget(context)),
                  _kSpacingBetweenRow,
                  new Expanded(flex: 9, child: _buildDaltWidget(context)),
                  _kSpacingBetweenRow,
                  _buildMIDLevelWidget(),
                  _kSpacingBetweenRow,
                  _kSpacingBetweenRow,
                  new Expanded(flex: 10, child: _buildDurationWidget(context)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndexIcon() {
    return const Center(
      child: const Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: const Text(
          '#',
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
      ),
    );
  }

  Widget _buildHdistWidget(final BuildContext context) {
    return new Text(
      context.l10n.horizontalDistanceHint,
      style: const TextStyle(fontSize: 16, color: Colors.black54),
    );
  }

  Widget _buildDaltWidget(final BuildContext context) {
    return new Text(
      context.l10n.daltitudeHint,
      style: const TextStyle(fontSize: 16, color: Colors.black54),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildMIDLevelWidget() {
    return SizedBox(
      width: 30,
      child: new Center(
        child: const Text(
          "M.I.D.",
          style: const TextStyle(fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDurationWidget(final BuildContext context) {
    return new Text(
      context.l10n.timeLabel,
      style: const TextStyle(fontSize: 16, color: Colors.black54),
      textAlign: TextAlign.end,
    );
  }
}

class MIDSelector extends StatelessWidget {
  MIDSelector({required this.value, required this.onChanged, super.key});

  /// The value of the currently selected [MIDLevel].
  final MIDLevel? value;

  /// Called when the user selects an item.
  final ValueChanged<MIDLevel> onChanged;

  final FocusNode _focus = new FocusNode();

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<MIDLevel>> items = MIDLevel.values
        .map<DropdownMenuItem<MIDLevel>>((e) => new DropdownMenuItem<MIDLevel>(
              value: e,
              child: new Text(e.toStringLocalized(context), maxLines: 1),
            ))
        .toList();

    final String tip =
        MIDLevel.values.map((e) => "• ${e.toStringLocalized(context)}: ${e.getTipLocalized(context)}").join("\n\n");

    return new SizedBox(
      width: 150,
      child: Row(
        children: <Widget>[
          new Flexible(
            child: new DropdownButtonFormField(
              focusNode: _focus,
              isExpanded: true,
              isDense: false,
              decoration: new InputDecoration(
                labelText: context.l10n.midLevelLabel,
                border: const OutlineInputBorder(),
                contentPadding: const EdgeInsets.only(left: 12),
              ),
              value: value,
              items: items,
              onChanged: (f) {
                _focus.unfocus();
                if (f != null) onChanged(f);
              },
              validator: (val) => _validator(context, val),
            ),
          ),
          kSpacingHorizontal,
          new TipWidget(tip: tip, forceDialog: true),
        ],
      ),
    );
  }

  String? _validator(final BuildContext context, final MIDLevel? val) {
    return val == null ? context.l10n.midSelectorValidationError : null;
  }
}
