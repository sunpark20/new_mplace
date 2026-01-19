package hungry.ex_frag.numSample;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.GridView;

import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdView;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashSet;

import hungry.ex_frag.ActivityHelper;
import hungry.ex_frag.NoticeActivity;
import hungry.ex_frag.R;
// Import the adapter from the 'numPrac' package
import hungry.ex_frag.numPrac.GridViewAdapter;

public class NumSample_Activity extends ActivityHelper {
    private ArrayList<Item> sampleAl = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_numsample);

        AdView mAdView = findViewById(R.id.adView111);
        AdRequest adRequest = new AdRequest.Builder().build();
        mAdView.loadAd(adRequest);

        readRawTextFile(this, R.raw.numsample);

        GridView gridview = findViewById(R.id.gridView);
        // Use the GridViewAdapter from numPrac, passing an empty HashSet for the score.
        gridview.setAdapter(new GridViewAdapter(this, makeDisplayList(), new HashSet<>()));

        gridview.setOnItemClickListener((parent, v, position, id) -> {
            if (position < sampleAl.size()) {
                Intent intent = new Intent(NumSample_Activity.this, NumSample_Dialog.class);
                intent.putExtra("item", sampleAl.get(position));
                startActivity(intent);
            }
        });
    }

    private void readRawTextFile(Context ctx, int resId) {
        InputStream inputStream = ctx.getResources().openRawResource(resId);
        try (BufferedReader buffreader = new BufferedReader(new InputStreamReader(inputStream))) {
            String line;
            int c = 0;
            Item item = null;
            while ((line = buffreader.readLine()) != null) {
                if (c % 4 == 1) {
                    item = new Item();
                    item.setName(line);
                } else if (c % 4 == 2 && item != null) {
                    item.setCha(line);
                } else if (c % 4 == 3 && item != null) {
                    item.setDes(line);
                    sampleAl.add(item);
                }
                c++;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    private ArrayList<String> makeDisplayList() {
        ArrayList<String> al = new ArrayList<>();
        for (int a = 0; a < 10; a++) {
            al.add(String.valueOf(a));
        }
        for (int a = 0; a < 100; a++) {
            al.add(String.format("%02d", a));
        }
        return al;
    }

    public void helpButtonOnClicked(View view) {
        Intent intent = new Intent(this, NoticeActivity.class);
        intent.putExtra("title", "설명서");
        intent.putExtra("image", R.drawable.d4_2);
        intent.putExtra("notice_text", getString(R.string.help2));
        startActivity(intent);
    }
}
