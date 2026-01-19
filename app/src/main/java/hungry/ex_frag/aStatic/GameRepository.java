package hungry.ex_frag.aStatic;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import java.lang.reflect.Type;
import java.util.HashSet;

import hungry.ex_frag.numPrac.SavedDate;

public class GameRepository {

    private static final String PREF_SCORE = "PREF_SCORE";
    private static final String PREF_SAVED_DATE = "PREF_savedDate";

    private final SharedPreferences sharedPreferences;
    private final Gson gson;

    public GameRepository(Context context) {
        this.sharedPreferences = PreferenceManager.getDefaultSharedPreferences(context.getApplicationContext());
        this.gson = new Gson();
    }

    public void saveScore(HashSet<Integer> score) {
        String json = gson.toJson(score);
        sharedPreferences.edit().putString(PREF_SCORE, json).apply();
    }

    public HashSet<Integer> loadScore() {
        String json = sharedPreferences.getString(PREF_SCORE, null);
        if (json == null) {
            return new HashSet<>();
        }
        Type type = new TypeToken<HashSet<Integer>>() {}.getType();
        return gson.fromJson(json, type);
    }

    public void saveSavedDate(SavedDate savedDate) {
        String json = gson.toJson(savedDate);
        sharedPreferences.edit().putString(PREF_SAVED_DATE, json).apply();
    }

    public SavedDate loadSavedDate() {
        String json = sharedPreferences.getString(PREF_SAVED_DATE, null);
        if (json == null) {
            return new SavedDate();
        }
        return gson.fromJson(json, SavedDate.class);
    }
}
