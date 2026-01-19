package hungry.ex_frag.numPrac;

import android.os.Bundle;
import android.widget.ListView;

import hungry.ex_frag.ActivityHelper;
import hungry.ex_frag.R;
import hungry.ex_frag.aStatic.GameRepository;

public class NumPrac_mem_date_Activity extends ActivityHelper {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_numprac_mem_date);

        ListView listView = findViewById(R.id.listView);
        GameRepository gameRepository = new GameRepository(this);
        SavedDate sd = gameRepository.loadSavedDate();

        // Corrected the adapter name to ListViewAdapter
        listView.setAdapter(new ListViewAdapter(this, sd));
    }
}
