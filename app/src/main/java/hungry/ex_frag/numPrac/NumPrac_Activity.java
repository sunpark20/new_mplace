package hungry.ex_frag.numPrac;

import android.content.Intent;
import android.os.Bundle;
import android.os.SystemClock;
import android.view.View;
import android.widget.Chronometer;
import android.widget.TextView;
import android.widget.Toast;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashSet;
import java.util.Locale;

import hungry.ex_frag.ActivityHelper;
import hungry.ex_frag.NoticeActivity;
import hungry.ex_frag.R;
import hungry.ex_frag.aStatic.GameRepository;

public class NumPrac_Activity extends ActivityHelper {
    private static final int SIZE_SET = 30;
    private static final int SIZE_TOTAL_NUM = 10000;

    private ArrayList<String> set;
    private HashSet<Integer> score;
    private int index = 0;
    private boolean isGameFinished = false;

    private TextView tv, s_correct, s_inco, s_total;
    private Chronometer cm;
    private GameRepository gameRepository;

    @Override
    protected void onSaveInstanceState(Bundle outState) {
        super.onSaveInstanceState(outState);
        outState.putLong("chronometer_base", cm.getBase());
        outState.putStringArrayList("set", set);
        outState.putSerializable("score", score);
        outState.putInt("index", index);
        outState.putBoolean("isGameFinished", isGameFinished);
        outState.putString("s_correct", s_correct.getText().toString());
        outState.putString("s_inco", s_inco.getText().toString());
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_numprac);

        AdView mAdView = findViewById(R.id.adView111);
        mAdView.loadAd(new AdRequest.Builder().build());

        tv = findViewById(R.id.tv);
        s_correct = findViewById(R.id.s_correct);
        s_inco = findViewById(R.id.s_inco);
        s_total = findViewById(R.id.s_total);
        cm = findViewById(R.id.cm);

        gameRepository = new GameRepository(this);

        if (savedInstanceState != null) {
            restoreGameState(savedInstanceState);
        } else {
            startNewGame();
        }

        updateUi();
    }

    private void restoreGameState(Bundle savedInstanceState) {
        set = savedInstanceState.getStringArrayList("set");
        score = (HashSet<Integer>) savedInstanceState.getSerializable("score");
        index = savedInstanceState.getInt("index");
        isGameFinished = savedInstanceState.getBoolean("isGameFinished");

        cm.setBase(savedInstanceState.getLong("chronometer_base"));
        s_correct.setText(savedInstanceState.getString("s_correct"));
        s_inco.setText(savedInstanceState.getString("s_inco"));

        if (!isGameFinished) {
            cm.start();
        }
    }

    private void startNewGame() {
        score = gameRepository.loadScore();
        set = makeNewSet();
        s_total.setText(String.valueOf(SIZE_SET));
        cm.setBase(SystemClock.elapsedRealtime());
        cm.start();
    }

    private void updateUi() {
        if (isGameFinished) {
            tv.setText("완료");
        } else if (set != null && !set.isEmpty()) {
            tv.setText(set.get(index));
        }
    }

    private ArrayList<String> makeNewSet() {
        ArrayList<String> allNumbers = new ArrayList<>();
        for (int i = 0; i < SIZE_TOTAL_NUM; i++) {
            allNumbers.add(String.format(Locale.US, "%04d", i));
        }
        Collections.shuffle(allNumbers);
        return new ArrayList<>(allNumbers.subList(0, SIZE_SET));
    }

    public void helpButtonOnClicked(View view) {
        Intent intent = new Intent(this, NoticeActivity.class);
        intent.putExtra("title", "설명서");
        intent.putExtra("notice_text", getString(R.string.help));
        startActivity(intent);
    }

    public void incoButtonOnClicked(View view) {
        if (isGameFinished) return;

        int currentInco = Integer.parseInt(s_inco.getText().toString()) + 1;
        s_inco.setText(String.valueOf(currentInco));

        index = (index + 1) % set.size();
        updateUi();
    }

    public void correctButtonOnClicked(View view) {
        if (isGameFinished) return;

        int numToRemove = Integer.parseInt(set.get(index));
        score.add(numToRemove);
        set.remove(index);

        int currentCorrect = Integer.parseInt(s_correct.getText().toString()) + 1;
        s_correct.setText(String.valueOf(currentCorrect));
        s_total.setText(String.valueOf(set.size()));

        if (set.isEmpty()) {
            finishGame();
        } else {
            index = index % set.size();
            updateUi();
        }
    }

    private void finishGame() {
        isGameFinished = true;
        cm.stop();
        tv.setText("완료");
        Toast.makeText(this, "모든 문제를 완료했습니다!", Toast.LENGTH_LONG).show();
        saveData();
    }

    private void saveData() {
        gameRepository.saveScore(score);

        SavedDate sd = gameRepository.loadSavedDate();
        String weekDay = new SimpleDateFormat("yyyy.MM.dd EEE HH:mm", Locale.getDefault()).format(Calendar.getInstance().getTime());
        sd.date.add(weekDay);
        sd.time.add(cm.getText().toString());
        sd.inco.add(s_inco.getText().toString());
        gameRepository.saveSavedDate(sd);
    }

    public void scoreCheckButtonOnClicked(View view) {
        Intent intent = new Intent(this, NumPrac_mem_Activity.class);
        startActivity(intent);
    }
}
