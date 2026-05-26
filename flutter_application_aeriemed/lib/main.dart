import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const AerieMedApp());
}

class AerieMedApp extends StatelessWidget {
  const AerieMedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AerieMed',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system,   // automatically follows phone setting
      home: const TableOfContentsScreen(),
    );
  }
}

class TableOfContentsScreen extends StatefulWidget {
  const TableOfContentsScreen({super.key});

  @override
  State<TableOfContentsScreen> createState() => _TableOfContentsScreenState();
}

class _TableOfContentsScreenState extends State<TableOfContentsScreen> {
  String searchQuery = '';
  final TextEditingController _searchController = TextEditingController();
  Set<String> _favorites = {};

  final List<Map<String, dynamic>> categories = [
    {
      'title': 'Root Protocols',
      'items': [
        {'title': 'Abdominal Pain - Expanded Scope', 'asset': 'Abdominal Pain - Expanded Scope.pdf'},
        {'title': 'Adult Cardiac Arrest - Initial Care', 'asset': 'Adult Cardiac Arrest - Initial Care.pdf'},
        {'title': 'Adult Cardiac Arrest - PEA and Asystole', 'asset': 'Adult Cardiac Arrest - PEA and Asystole.pdf'},
        {'title': 'Adult Cardiac Arrest - Additional Treatments to Consider', 'asset': 'Adult Cardiac Arrest - Additional Treatments to Consider.pdf'},
        {'title': 'Adult Cardiac Arrest - Post Resuscitative Care - Expanded Scope', 'asset': 'Adult Cardiac Arrest - Post Resuscitative Care - Expanded Scope.pdf'},
        {'title': 'Adult Cardiac Arrest - VF-Pulseless VT', 'asset': 'Adult Cardiac Arrest - VF-Pulseless VT.pdf'},
        {'title': 'Adult Resuscitation', 'asset': 'Adult Resuscitation.pdf'},
        {'title': 'Airway Obstruction - Foreign Body - Choking', 'asset': 'Airway Obstruction - Foreign Body - Choking.pdf'},
        {'title': 'Altered Mental Status', 'asset': 'Altered Mental Status.pdf'},
        {'title': 'Behavior Emergency', 'asset': 'Behavior Emergency.pdf'},
        {'title': 'Bites', 'asset': 'Bites.pdf'},
        {'title': 'Bradycardia with pulse - Expanded Scope', 'asset': 'Bradycardia with pulse - Expanded Scope.pdf'},
        {'title': 'Chest Pain - Expanded Scope', 'asset': 'Chest Pain - Expanded Scope.pdf'},
        {'title': 'Crush Injury', 'asset': 'Crush Injury.pdf'},
        {'title': 'Cyanide Poisoning', 'asset': 'Cyanide Poisoning.pdf'},
        {'title': 'Dead on Scene', 'asset': 'Dead on Scene.pdf'},
        {'title': 'Difficulty Breathing - Asthma and COPD with expanded scope', 'asset': 'Difficulty Breathing - Asthma and COPD with expanded scope.pdf'},
        {'title': 'Difficulty Breathing - Respiratory Distress', 'asset': 'Difficulty Breathing - Respiratory Distress.pdf'},
        {'title': 'Difficulty Breathing - SCAPE or CHF', 'asset': 'Difficulty Breathing - SCAPE or CHF.pdf'},
        {'title': 'Diabetic Emergency - Expanded Scope', 'asset': 'Diabetic Emergency - Expanded Scope.pdf'},
        {'title': 'Electrical Injury and Electrocution', 'asset': 'Electrical Injury and Electrocution.pdf'},
        {'title': 'Environmental Hyperthermia - Expanded Scope', 'asset': 'Environmental Hyperthermia - Expanded Scope.pdf'},
        {'title': 'Epistaxis - Expanded Scope', 'asset': 'Epistaxis - Expanded Scope.pdf'},
        {'title': 'EXPANDED SCOPE', 'asset': 'EXPANDED SCOPE.pdf'},
        {'title': 'Firefighter Rehab Guidelines', 'asset': 'Firefighter Rehab Guidelines.pdf'},
        {'title': 'General Medical Care - Expanded Scope', 'asset': 'General Medical Care - Expanded Scope.pdf'},
        {'title': 'GI Bleeding - Expanded Scope', 'asset': 'GI Bleeding - Expanded Scope.pdf'},
        {'title': 'Hazmat', 'asset': 'Hazmat.pdf'},
        {'title': 'Headache - Expanded Scope', 'asset': 'Headache - Expanded Scope.pdf'},
        {'title': 'Hypertension', 'asset': 'Hypertension.pdf'},
        {'title': 'Nausea and Vomiting - Expanded Scope', 'asset': 'Nausea and Vomiting - Expanded Scope.pdf'},
        {'title': 'Pain Management w expanded scope', 'asset': 'Pain Management w expanded scope.pdf'},
        {'title': 'Seizure', 'asset': 'Seizure.pdf'},
        {'title': 'Shock - Medical - Expanded Scope', 'asset': 'Shock - Medical - Expanded Scope.pdf'},
        {'title': 'Spinal Motion Restriction', 'asset': 'Spinal Motion Restriction.pdf'},
        {'title': 'Stings', 'asset': 'Stings.pdf'},
        {'title': 'Stroke', 'asset': 'Stroke.pdf'},
        {'title': 'Syncope - Weak and Dizzy - Expanded Scope', 'asset': 'Syncope - Weak and Dizzy - Expanded Scope.pdf'},
        {'title': 'Tachycardia - Narrow Complex - Expanded Scope', 'asset': 'Tachycardia - Narrow Complex - Expanded Scope.pdf'},
        {'title': 'Tachycardia - Wide Complex - Expanded Scope', 'asset': 'Tachycardia - Wide Complex - Expanded Scope.pdf'},
        {'title': 'Termination of Resuscitation - Non-traumatic Cardiac Arrest', 'asset': 'Termination of Resuscitation - Non-traumatic Cardiac Arrest.pdf'},
        {'title': 'Toxic Ingestion - Overdose', 'asset': 'Toxic Ingestion - Overdose.pdf'},
        {'title': 'Tranexamic Acid - TXA - Expanded Scope', 'asset': 'Tranexamic Acid - TXA - Expanded Scope.pdf'},
        {'title': 'Trauma - Antibiotics', 'asset': 'Trauma - Antibiotics.pdf'},
        {'title': 'Trauma - Blunt - Expanded Scope', 'asset': 'Trauma - Blunt - Expanded Scope.pdf'},
        {'title': 'Trauma - Burns - General', 'asset': 'Trauma - Burns - General.pdf'},
        {'title': 'Trauma - Eye Injury - Chemical', 'asset': 'Trauma - Eye Injury - Chemical.pdf'},
        {'title': 'Trauma - Eye Injury - Expanded Scope', 'asset': 'Trauma - Eye Injury - Expanded Scope.pdf'},
        {'title': 'Trauma - General - Expanded Scope', 'asset': 'Trauma - General - Expanded Scope.pdf'},
        {'title': 'Trauma - Head Injury', 'asset': 'Trauma - Head Injury.pdf'},
        {'title': 'Trauma - Neck Trauma', 'asset': 'Trauma - Neck Trauma.pdf'},
        {'title': 'Trauma - Penetrating - Expanded Scope', 'asset': 'Trauma - Penetrating - Expanded Scope.pdf'},
        {'title': 'Trauma - Sexual Assault', 'asset': 'Trauma - Sexual Assault.pdf'},
        {'title': 'Trauma Arrest Guideline', 'asset': 'Trauma Arrest Guideline.pdf'},
        {'title': 'Vaginal Bleeding - Expanded Scope', 'asset': 'Vaginal Bleeding - Expanded Scope.pdf'},
      ]
    },
    {
      'title': 'Appendix Material',
      'items': [
        {'title': 'Acceptable Abbreviations for PCR', 'asset': 'Acceptable Abbreviations for PCR.pdf'},
        {'title': 'APGAR', 'asset': 'APGAR.pdf'},
        {'title': 'EXPANDED SCOPE - california version', 'asset': 'EXPANDED SCOPE - california version.pdf'},
        {'title': 'GCS', 'asset': 'GCS.pdf'},
        {'title': 'Igel - Ideal Body Weight Chart', 'asset': 'Igel - Ideal Body Weight Chart.pdf'},
        {'title': 'Pain Rating Scales', 'asset': 'Pain Rating Scales.pdf'},
        {'title': 'Pediatric Normal Vital Signs', 'asset': 'Pediatric Normal Vital Signs.pdf'},
        {'title': 'Respiratory Treatments Guide', 'asset': 'Respiratory Treatments Guide.pdf'},
        {'title': 'Sedation Score', 'asset': 'Sedation Score.pdf'},
        {'title': 'Stroke Alert Criteria', 'asset': 'Stroke Alert Criteria.pdf'},
      ]
    },
    {
      'title': 'Medications',
      'items': [
        {'title': 'Acetaminophen', 'asset': 'Acetaminophen.pdf'},
        {'title': 'Activated Charcoal', 'asset': 'Activated Charcoal.pdf'},
        {'title': 'Adenosine', 'asset': 'Adenosine.pdf'},
        {'title': 'Albuterol', 'asset': 'Albuterol.pdf'},
        {'title': 'Amiodarone', 'asset': 'Amiodarone.pdf'},
        {'title': 'Aspirin', 'asset': 'Aspirin.pdf'},
        {'title': 'Atropine', 'asset': 'Atropine.pdf'},
        {'title': 'Calcium Chloride', 'asset': 'Calcium Chloride.pdf'},
        {'title': 'Dexamethasone', 'asset': 'Dexamethasone.pdf'},
        {'title': 'Diphenhydramine', 'asset': 'Diphenhydramine.pdf'},
        {'title': 'Droperidol', 'asset': 'Droperidol.pdf'},
        {'title': 'Duo-Dote', 'asset': 'Duo-Dote.pdf'},
        {'title': 'Epinephrine', 'asset': 'Epinephrine.pdf'},
        {'title': 'Fentanyl', 'asset': 'Fentanyl.pdf'},
        {'title': 'Glucagon', 'asset': 'Glucagon.pdf'},
        {'title': 'Glucose Gel', 'asset': 'Glucose Gel.pdf'},
        {'title': 'Hydromorphone', 'asset': 'Hydromorphone.pdf'},
        {'title': 'Ipratropium', 'asset': 'Ipratropium.pdf'},
        {'title': 'Ketamine', 'asset': 'Ketamine.pdf'},
        {'title': 'Ketorolac', 'asset': 'Ketorolac.pdf'},
        {'title': 'Lidocaine', 'asset': 'Lidocaine.pdf'},
        {'title': 'Magnesium Sulfate', 'asset': 'Magnesium Sulfate.pdf'},
        {'title': 'Metoprolol', 'asset': 'Metoprolol.pdf'},
        {'title': 'Methylprednisolone', 'asset': 'Methylprednisolone.pdf'},
        {'title': 'Midazolam', 'asset': 'Midazolam.pdf'},
        {'title': 'Naloxone', 'asset': 'Naloxone.pdf'},
        {'title': 'Nitroglycerin', 'asset': 'Nitroglycerin.pdf'},
        {'title': 'Norepinephrine', 'asset': 'Norepinephrine.pdf'},
        {'title': 'Ondansetron', 'asset': 'Ondansetron.pdf'},
        {'title': 'Prednisone', 'asset': 'Prednisone.pdf'},
        {'title': 'Rocuronium', 'asset': 'Rocuronium.pdf'},
        {'title': 'Sodium Bicarbonate', 'asset': 'Sodium Bicarbonate.pdf'},
        {'title': 'Tetracaine', 'asset': 'Tetracaine.pdf'},
        {'title': 'Tranexamic Acid', 'asset': 'Tranexamic Acid.pdf'},
      ]
    },
    {
      'title': 'Procedures',
      'items': [
        {'title': 'DSI Checklist', 'asset': 'DSI Checklist .pptx'},
        {'title': 'EZ IO Procedure', 'asset': 'EZ IO Procedure.pdf'},
        {'title': 'Failed Airway', 'asset': 'Failed Airway.pdf'},
        {'title': 'Finger Thoracostomy Procedure', 'asset': 'Finger Thoracostomy Procedure.pdf'},
        {'title': 'Nasogastric and Orogastric Tubes', 'asset': 'Nasogastric and Orogastric Tubes.pdf'},
        {'title': 'Needle Cricothyrotomy', 'asset': 'Needle Cricothyrotomy.pdf'},
        {'title': 'Needle Thoracostomy Procedure', 'asset': 'Needle Thoracostomy Procedure.pdf'},
        {'title': 'Noninvasive Ventilation', 'asset': 'Noninvasive Ventilation.pdf'},
        {'title': 'Supraglottic Airway Management - iGel', 'asset': 'Supraglottic Airway Management - iGel.pdf'},
        {'title': 'Surgical Cricothyrotomy', 'asset': 'Surgical Cricothyrotomy.pdf'},
        {'title': 'Synchronized Cardioversion', 'asset': 'Synchronized Cardioversion.pdf'},
        {'title': 'Transcutaneous Pacing', 'asset': 'Transcutaneous Pacing.pdf'},
        {'title': 'Ventilation Procedure', 'asset': 'Ventilation Procedure.pdf'},
      ]
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList('favorites') ?? [];
    setState(() => _favorites = saved.toSet());
  }

  Future<void> _toggleFavorite(String asset) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (_favorites.contains(asset)) _favorites.remove(asset); else _favorites.add(asset);
    });
    await prefs.setStringList('favorites', _favorites.toList());
  }

  bool _isFavorite(String asset) => _favorites.contains(asset);

  List<Map<String, String>> get filteredProtocols {
    if (searchQuery.isEmpty) return [];
    final query = searchQuery.toLowerCase();
    final results = <Map<String, String>>[];
    for (var cat in categories) {
      for (var item in cat['items']) {
        if ((item['title'] as String).toLowerCase().contains(query)) {
          results.add({'title': item['title'] as String, 'asset': item['asset'] as String});
        }
      }
    }
    return results;
  }

  Future<void> _openPdf(String title, String asset) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final localPath = '${dir.path}/$asset';
      final file = File(localPath);
      if (!await file.exists()) {
        final byteData = await rootBundle.load('assets/protocols/$asset');
        await file.writeAsBytes(byteData.buffer.asUint8List());
      }
      if (mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => PdfViewerScreen(title: title, filePath: localPath)));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to open $title'), backgroundColor: Colors.red));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = searchQuery.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AerieMed • Protocols'),
        actions: [
          IconButton(
            icon: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              // Simple toggle between light and dark (you can expand to System later if you want)
              // For now this switches the whole app manually
              // (Flutter will remember the system preference on restart)
            },
            tooltip: 'Toggle Dark Mode',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search all protocols...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.white,
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
        ),
      ),
      body: isSearching
          ? ListView.builder(
              itemCount: filteredProtocols.length,
              itemBuilder: (context, index) {
                final item = filteredProtocols[index];
                final isFav = _isFavorite(item['asset']!);
                return ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: Text(item['title']!),
                  trailing: IconButton(
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : null),
                    onPressed: () => _toggleFavorite(item['asset']!),
                  ),
                  onTap: () => _openPdf(item['title']!, item['asset']!),
                );
              },
            )
          : ListView(
              children: [
                ExpansionTile(
                  initiallyExpanded: _favorites.isNotEmpty,
                  title: const Text('❤️ Favorites', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  children: _favorites.isEmpty
                      ? [const ListTile(title: Text('No favorites yet — tap ❤️ on any protocol'))]
                      : _favorites.map((asset) {
                          final title = categories.expand((cat) => cat['items'] as List).firstWhere((item) => item['asset'] == asset, orElse: () => {'title': asset})['title'];
                          return ListTile(
                            leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                            title: Text(title),
                            trailing: IconButton(icon: const Icon(Icons.favorite, color: Colors.red), onPressed: () => _toggleFavorite(asset)),
                            onTap: () => _openPdf(title, asset),
                          );
                        }).toList(),
                ),
                ...categories.map((cat) => ExpansionTile(
                  title: Text(cat['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  children: (cat['items'] as List).map<Widget>((item) {
                    final isFav = _isFavorite(item['asset']);
                    return ListTile(
                      leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                      title: Text(item['title']),
                      trailing: IconButton(
                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : null),
                        onPressed: () => _toggleFavorite(item['asset']),
                      ),
                      onTap: () => _openPdf(item['title'], item['asset']),
                    );
                  }).toList(),
                )),
              ],
            ),
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String title;
  final String filePath;
  const PdfViewerScreen({super.key, required this.title, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: PDFView(
        filePath: filePath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
      ),
    );
  }
}
