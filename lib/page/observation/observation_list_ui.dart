import 'package:aplicativoescolas/database/observation_provider.dart';
import 'package:aplicativoescolas/model/observation.dart';
import 'package:aplicativoescolas/model/observation.dart';
import 'package:aplicativoescolas/model/student.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:toast/toast.dart';
import 'custom_show_dialog.dart';

class ObservationListPage extends StatefulWidget {
  @override
  _ObservationListPageState createState() => _ObservationListPageState();
}

class _ObservationListPageState extends State<ObservationListPage> {
  TextEditingController obsTex = TextEditingController();

  var now = new DateTime.now();

  Student student;

  @override
  Widget build(BuildContext context) {
    student = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        student.name,
        style: TextStyle(color: Colors.white),
      )),
      body: DefaultTextStyle.merge(
        style: const TextStyle(
          fontSize: 16.0,
          //fontFamily: 'monospace',
        ),
        child: FutureBuilder(
          future: ObservationProvider.db.getAllObservationWithId(student.id),
          builder: (BuildContext context,
              AsyncSnapshot<List<Observation>> snapshot) {
            return ListView.builder(
              itemCount: snapshot.data != null ? snapshot.data.length : 0,
              itemBuilder: (context, index) {
                return Container(
                    child: Slidable(
                  key: ValueKey(index),
                  actionPane: SlidableDrawerActionPane(),
                  secondaryActions: <Widget>[
                    Container(
                      height: 100,
                      child: IconSlideAction(
                        caption: 'Editar',
                        color: Colors.grey.shade300,
                        icon: Icons.edit,
                        closeOnTap: true,
                        onTap: () {
                          diologObs(
                              context: context,
                              edit: true,
                              observation: snapshot.data[index]);
                        },
                      ),
                    ),
                    Container(
                      height: 100,
                      child: IconSlideAction(
                        caption: 'Deletar',
                        color: Colors.red,
                        icon: Icons.delete,
                        closeOnTap: true,
                        onTap: () {
                          Toast.show('removido com sucesso', context,
                              duration: Toast.LENGTH_SHORT,
                              gravity: Toast.BOTTOM);
                          setState(() {
                            setState(() {
                              ObservationProvider.db.deleteObservationWithId(
                                  snapshot.data[index].id);
                            });
                          });
                        },
                      ),
                    )
                  ],
                  child: Container(
                    decoration: BoxDecoration(
                        border: new BorderDirectional(
                      bottom: BorderSide(
                        color: Colors.blue.shade100,
                        width: 1.5,
                      ),
                    )),
                    child: observationCard(snapshot.data[index]),
                  ),
                ));
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            TextEditingController obsTex = TextEditingController();
            return diologObs(context: context);
          }),
    );
  }

  Widget diologObs({BuildContext context, bool edit, Observation observation}) {
    edit == true
        ? obsTex.text = observation.observation.toString()
        : obsTex.text = "";

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
              content: new Container(
            width: 260.0,
            height: 400.0,
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: const Color(0xFFFFFF),
              borderRadius: new BorderRadius.all(new Radius.circular(20.0)),
            ),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // dialog top
                new Row(
                  children: <Widget>[
                    new Container(
                      // padding: new EdgeInsets.all(10.0),
                      decoration: new BoxDecoration(
                        color: Colors.white,
                      ),
                      child: new Text(
                        'Escreva uma observação',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                          fontFamily: 'helvetica_neue_light',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                // dialog centre
                new Flexible(
                  child: new Container(
                      width: 10,
                      height: MediaQuery.of(context).size.height,
                      child: new TextField(
                        controller: obsTex,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: new InputDecoration(
                          border: InputBorder.none,
                          filled: false,
                          contentPadding: new EdgeInsets.only(
                              left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                          hintText: ' insira aqui seu texto',
                          hintStyle: new TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12.0,
                            fontFamily: 'helvetica_neue_light',
                          ),
                        ),
                      )),
                ),
                Expanded(
                  flex: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          setState(() {
                             Navigator.pop(context);
                          });
                        },
                        child: Container(
                          alignment: Alignment.bottomCenter,
                          padding: new EdgeInsets.all(8.0),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: new Text(
                            'Cancelar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (edit == true && obsTex.text != "") {
                            observation.observation = obsTex.text;
                            observation.ano = now.year;
                            observation.mes = now.month;
                            observation.dia = now.day;
                            setState(() {
                              ObservationProvider.db
                                  .updateObservation(observation);
                              Navigator.pop(context);
                            });
                          } else {
                            if (obsTex.text != "" ) {
                              Observation obj = Observation();
                              obj.observation = obsTex.text;
                              obj.idStudent = student.id;
                              obj.ano = now.year;
                              obj.mes = now.month;
                              obj.dia = now.day;
                              setState(() {
                                ObservationProvider.db
                                    .addObservationToDatabase(obj);
                                obsTex.text = "";
                                Navigator.pop(context);
                              });
                            }
                          }
                        },
                        child: Container(
                          width: 120,
                          alignment: Alignment.bottomCenter,
                          padding: new EdgeInsets.all(8.0),
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blue,
                          ),
                          child: new Text(
                            'Salvar',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'helvetica_neue_light',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ));
        });
  }

  Widget observationCard(Observation observation) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ReadMoreText(
            observation.observation,
            trimLines: 1,
            colorClickableText: Colors.blue,
            trimMode: TrimMode.Line,
            trimCollapsedText: '...mostrar',
            trimExpandedText: ' fechar',
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Última atualização em " +
                observation.dia.toString() +
                "/" +
                observation.mes.toString() +
                "/" +
                observation.ano.toString(),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

enum TrimMode {
  Length,
  Line,
}

class ReadMoreText extends StatefulWidget {
  const ReadMoreText(
    this.data, {
    Key key,
    this.trimExpandedText = '',
    this.trimCollapsedText = '',
    this.colorClickableText,
    this.trimLength = 240,
    this.trimLines = 2,
    this.trimMode = TrimMode.Length,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.textScaleFactor,
    this.semanticsLabel,
  })  : assert(data != null),
        super(key: key);

  final String data;
  final String trimExpandedText;
  final String trimCollapsedText;
  final Color colorClickableText;
  final int trimLength;
  final int trimLines;
  final TrimMode trimMode;
  final TextStyle style;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final Locale locale;
  final double textScaleFactor;
  final String semanticsLabel;

  @override
  ReadMoreTextState createState() => ReadMoreTextState();
}

const String _kEllipsis = '\u2026';

const String _kLineSeparator = '\u2028';

class ReadMoreTextState extends State<ReadMoreText> {
  bool _readMore = true;

  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    TextStyle effectiveTextStyle = widget.style;
    if (widget.style == null || widget.style.inherit) {
      effectiveTextStyle = defaultTextStyle.style.merge(widget.style);
    }

    final textAlign =
        widget.textAlign ?? defaultTextStyle.textAlign ?? TextAlign.start;
    final textDirection = widget.textDirection ?? Directionality.of(context);
    final textScaleFactor =
        widget.textScaleFactor ?? MediaQuery.textScaleFactorOf(context);
    final overflow = defaultTextStyle.overflow;
    final locale =
        widget.locale ?? Localizations.localeOf(context, nullOk: true);

    final colorClickableText =
        widget.colorClickableText ?? Theme.of(context).accentColor;

    TextSpan link = TextSpan(
      text: _readMore ? widget.trimCollapsedText : widget.trimExpandedText,
      style: effectiveTextStyle.copyWith(
        color: colorClickableText,
      ),
      recognizer: TapGestureRecognizer()..onTap = _onTapLink,
    );

    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;

        // Create a TextSpan with data
        final text = TextSpan(
          style: effectiveTextStyle,
          text: widget.data,
        );

        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textAlign: textAlign,
          textDirection: textDirection,
          textScaleFactor: textScaleFactor,
          maxLines: widget.trimLines,
          ellipsis: overflow == TextOverflow.ellipsis ? _kEllipsis : null,
          locale: locale,
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;

        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;

        print('linkSize $linkSize textSize $textSize');

        // Get the endIndex of data
        bool linkLongerThanLine = false;
        int endIndex;

        if (linkSize.width < maxWidth) {
          final pos = textPainter.getPositionForOffset(Offset(
            textSize.width - linkSize.width,
            textSize.height,
          ));
          endIndex = textPainter.getOffsetBefore(pos.offset);
        } else {
          var pos = textPainter.getPositionForOffset(
            textSize.bottomLeft(Offset.zero),
          );
          endIndex = pos.offset;
          linkLongerThanLine = true;
        }

        var textSpan;
        switch (widget.trimMode) {
          case TrimMode.Length:
            if (widget.trimLength < widget.data.length) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, widget.trimLength)
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          case TrimMode.Line:
            if (textPainter.didExceedMaxLines) {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: _readMore
                    ? widget.data.substring(0, endIndex) +
                        (linkLongerThanLine ? _kLineSeparator : '')
                    : widget.data,
                children: <TextSpan>[link],
              );
            } else {
              textSpan = TextSpan(
                style: effectiveTextStyle,
                text: widget.data,
              );
            }
            break;
          default:
            throw Exception(
                'TrimMode type: ${widget.trimMode} is not supported');
        }

        return RichText(
          textAlign: textAlign,
          textDirection: textDirection,
          softWrap: true,
          //softWrap,
          overflow: TextOverflow.clip,
          //overflow,
          textScaleFactor: textScaleFactor,
          text: textSpan,
        );
      },
    );
    if (widget.semanticsLabel != null) {
      result = Semantics(
        textDirection: widget.textDirection,
        label: widget.semanticsLabel,
        child: ExcludeSemantics(
          child: result,
        ),
      );
    }
    return result;
  }
}
