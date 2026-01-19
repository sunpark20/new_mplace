package hungry.ex_frag.numPrac;

import android.os.Bundle;
import android.widget.GridView;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Locale;

import hungry.ex_frag.ActivityHelper;
import hungry.ex_frag.R;
import hungry.ex_frag.aStatic.GameRepository;

public class NumPrac_mem_score_Activity extends ActivityHelper {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_numprac_mem_score);

        GridView gridview = findViewById(R.id.gridView);

        GameRepository gameRepository = new GameRepository(this);
        HashSet<Integer> score = gameRepository.loadScore();

        // The adapter needs the score set to highlight the correct items.
        // I will modify the GridViewAdapter to accept this score set in the next step.
        gridview.setAdapter(new GridViewAdapter(this, makeSet(), score));
    }

    private ArrayList<String> makeSet() {
        ArrayList<String> al = new ArrayList<>();
        final int SIZE_TOTALNUM = 10000;
        for (int a = 0; a < SIZE_TOTALNUM; a++) {
            al.add(String.format(Locale.US, "%04d", a));
        }
        return al;
    }
}
