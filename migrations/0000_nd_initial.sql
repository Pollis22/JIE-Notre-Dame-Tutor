CREATE TABLE "access_codes" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"code" varchar(50) NOT NULL,
	"label" text,
	"max_uses" integer,
	"times_used" integer DEFAULT 0,
	"expires_at" timestamp NOT NULL,
	"is_active" boolean DEFAULT true,
	"created_by" varchar,
	"created_at" timestamp DEFAULT now(),
	CONSTRAINT "access_codes_code_unique" UNIQUE("code")
);
--> statement-breakpoint
CREATE TABLE "admin_logs" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"admin_id" varchar NOT NULL,
	"action" text NOT NULL,
	"target_type" text NOT NULL,
	"target_id" text,
	"details" jsonb,
	"timestamp" timestamp DEFAULT now() NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "agent_sessions" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"student_id" varchar,
	"agent_id" text,
	"conversation_id" text,
	"base_agent_id" text,
	"knowledge_base_id" text,
	"student_name" text NOT NULL,
	"grade_band" text NOT NULL,
	"subject" text NOT NULL,
	"document_ids" text[],
	"file_ids" text[],
	"created_at" timestamp DEFAULT now(),
	"expires_at" timestamp NOT NULL,
	"ended_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "content_violations" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"session_id" varchar,
	"violation_type" text NOT NULL,
	"severity" text NOT NULL,
	"user_message" text NOT NULL,
	"ai_response" text,
	"confidence" numeric(3, 2),
	"review_status" text DEFAULT 'pending',
	"action_taken" text,
	"notified_parent" boolean DEFAULT false,
	"notified_support" boolean DEFAULT false,
	"reviewed_by" varchar,
	"reviewed_at" timestamp,
	"review_notes" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "digest_tracking" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"digest_type" varchar(20) NOT NULL,
	"digest_date" date NOT NULL,
	"session_count" integer NOT NULL,
	"email_sent_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "document_chunks" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"document_id" varchar NOT NULL,
	"chunk_index" integer NOT NULL,
	"content" text NOT NULL,
	"token_count" integer,
	"metadata" jsonb,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "document_embeddings" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"chunk_id" varchar NOT NULL,
	"embedding" vector(1536) NOT NULL,
	"embedding_model" text DEFAULT 'text-embedding-3-small',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "learning_sessions" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"lesson_id" varchar,
	"session_type" text NOT NULL,
	"context_documents" jsonb,
	"transcript" text,
	"voice_minutes_used" integer DEFAULT 0,
	"started_at" timestamp DEFAULT now(),
	"ended_at" timestamp,
	"is_completed" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "lessons" (
	"id" varchar PRIMARY KEY NOT NULL,
	"subject_id" varchar NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"content" jsonb NOT NULL,
	"practice_problems" text,
	"answer_key" text,
	"order_index" integer NOT NULL,
	"estimated_minutes" integer DEFAULT 15,
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "marketing_campaigns" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"admin_id" varchar NOT NULL,
	"campaign_name" text NOT NULL,
	"segment" text NOT NULL,
	"contact_count" integer NOT NULL,
	"filters" jsonb,
	"exported_at" timestamp DEFAULT now() NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "memory_jobs" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"job_type" varchar(50) NOT NULL,
	"user_id" varchar NOT NULL,
	"student_id" varchar,
	"session_id" varchar NOT NULL,
	"status" varchar(20) DEFAULT 'pending' NOT NULL,
	"attempts" integer DEFAULT 0 NOT NULL,
	"last_error" text,
	"run_after" timestamp DEFAULT now(),
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "minute_purchases" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"minutes_purchased" integer NOT NULL,
	"minutes_remaining" integer NOT NULL,
	"price_paid" numeric(10, 2),
	"purchased_at" timestamp DEFAULT now() NOT NULL,
	"expires_at" timestamp,
	"status" text DEFAULT 'active',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "notification_preferences" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"child_id" varchar,
	"recipient_email" text NOT NULL,
	"recipient_name" text,
	"recipient_role" text DEFAULT 'self' NOT NULL,
	"frequency" text DEFAULT 'off' NOT NULL,
	"horizon_days" integer DEFAULT 7 NOT NULL,
	"day_of_week" integer DEFAULT 0 NOT NULL,
	"hour_local" integer DEFAULT 18 NOT NULL,
	"timezone" text DEFAULT 'America/New_York' NOT NULL,
	"at_risk_alerts" boolean DEFAULT false NOT NULL,
	"is_active" boolean DEFAULT true NOT NULL,
	"last_sent_at" timestamp,
	"last_at_risk_sent_at" timestamp,
	"unsubscribe_token" text DEFAULT encode(gen_random_bytes(18), 'hex') NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL,
	"updated_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "page_views" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"page_path" text NOT NULL,
	"page_title" text,
	"session_id" text,
	"user_id" varchar,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "practice_lessons" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"grade" varchar(10) NOT NULL,
	"subject" varchar(50) NOT NULL,
	"topic" varchar(100) NOT NULL,
	"lesson_title" varchar(200) NOT NULL,
	"learning_goal" text NOT NULL,
	"tutor_introduction" text NOT NULL,
	"guided_questions" jsonb NOT NULL,
	"practice_prompts" jsonb NOT NULL,
	"check_understanding" text NOT NULL,
	"encouragement_close" text NOT NULL,
	"difficulty_level" integer DEFAULT 1,
	"estimated_minutes" integer DEFAULT 10,
	"order_index" integer NOT NULL,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "quiz_attempts" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"lesson_id" varchar NOT NULL,
	"session_id" varchar,
	"answers" jsonb NOT NULL,
	"score" integer NOT NULL,
	"total_questions" integer NOT NULL,
	"time_spent" integer,
	"completed_at" timestamp DEFAULT now(),
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "realtime_sessions" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"student_id" varchar,
	"student_name" text,
	"subject" text,
	"language" text DEFAULT 'en',
	"age_group" text DEFAULT '3-5',
	"voice" text,
	"model" text DEFAULT 'gpt-4o-realtime-preview-2024-10-01',
	"status" text DEFAULT 'connecting',
	"transcript" jsonb DEFAULT '[]'::jsonb,
	"summary" text,
	"total_messages" integer DEFAULT 0,
	"ai_cost" numeric(10, 4) DEFAULT '0',
	"audio_url" text,
	"context_documents" jsonb,
	"started_at" timestamp DEFAULT now(),
	"ended_at" timestamp,
	"minutes_used" integer DEFAULT 0,
	"error_message" text,
	"safety_flags" jsonb DEFAULT '[]'::jsonb,
	"strike_count" integer DEFAULT 0,
	"terminated_for_safety" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now(),
	"close_reason" text,
	"close_details" jsonb,
	"reconnect_count" integer DEFAULT 0,
	"last_heartbeat_at" timestamp
);
--> statement-breakpoint
CREATE TABLE "registration_tokens" (
	"token" varchar(64) PRIMARY KEY NOT NULL,
	"account_name" text NOT NULL,
	"student_name" text NOT NULL,
	"student_age" integer,
	"grade_level" text NOT NULL,
	"primary_subject" text,
	"email" text NOT NULL,
	"password" text NOT NULL,
	"selected_plan" text NOT NULL,
	"marketing_opt_in" boolean DEFAULT false,
	"expires_at" timestamp NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "safety_incidents" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"session_id" varchar,
	"student_id" varchar,
	"user_id" varchar,
	"flag_type" varchar(50) NOT NULL,
	"severity" varchar(20) NOT NULL,
	"trigger_text" text,
	"tutor_response" text,
	"action_taken" varchar(50),
	"admin_notified" boolean DEFAULT false,
	"parent_notified" boolean DEFAULT false,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "session_summaries" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"student_id" varchar,
	"session_id" varchar NOT NULL,
	"summary_text" text NOT NULL,
	"topics_covered" text[] DEFAULT '{}'::text[] NOT NULL,
	"concepts_mastered" text[],
	"concepts_struggled" text[],
	"student_insights" text,
	"subject" varchar(100),
	"grade_band" varchar(50),
	"duration_minutes" integer,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "sessions" (
	"sid" varchar PRIMARY KEY NOT NULL,
	"sess" jsonb NOT NULL,
	"expire" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE "student_calendar_events" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"course_id" varchar,
	"title" text NOT NULL,
	"event_type" text,
	"description" text,
	"start_date" date NOT NULL,
	"end_date" date,
	"start_time" text,
	"end_time" text,
	"location" text,
	"is_all_day" boolean DEFAULT false,
	"is_from_syllabus" boolean DEFAULT true,
	"priority" text,
	"status" text DEFAULT 'upcoming',
	"notes" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "student_courses" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"course_name" text NOT NULL,
	"course_code" text,
	"instructor" text,
	"semester" text,
	"syllabus_text" text,
	"syllabus_uploaded_at" timestamp,
	"color" text,
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "student_doc_pins" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"student_id" varchar NOT NULL,
	"doc_id" varchar NOT NULL,
	"pinned_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "student_engagement_scores" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"course_id" varchar,
	"week_start" date,
	"sessions_completed" integer DEFAULT 0,
	"tasks_completed" integer DEFAULT 0,
	"tasks_pending" integer DEFAULT 0,
	"tasks_missed" integer DEFAULT 0,
	"total_study_minutes" integer DEFAULT 0,
	"engagement_score" numeric(5, 2) DEFAULT '0',
	"trend" text DEFAULT 'stable',
	"risk_level" text DEFAULT 'on_track',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "student_lesson_progress" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"student_id" varchar NOT NULL,
	"lesson_id" varchar NOT NULL,
	"status" varchar(20) DEFAULT 'not_started',
	"session_id" varchar,
	"started_at" timestamp,
	"completed_at" timestamp,
	"time_spent_seconds" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "student_parent_shares" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"parent_email" text NOT NULL,
	"parent_name" text,
	"share_frequency" text DEFAULT 'weekly',
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "student_reminders" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"event_id" varchar,
	"task_id" varchar,
	"reminder_type" text,
	"reminder_date" date,
	"reminder_time" text,
	"message" text,
	"delivered" boolean DEFAULT false,
	"delivered_at" timestamp,
	"delivery_method" text DEFAULT 'in_app',
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "student_tasks" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"course_id" varchar,
	"event_id" varchar,
	"title" text NOT NULL,
	"task_type" text,
	"due_date" date,
	"priority" text,
	"status" text DEFAULT 'pending',
	"estimated_minutes" integer,
	"actual_minutes" integer,
	"notes" text,
	"completed_at" timestamp,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "students" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"owner_user_id" varchar NOT NULL,
	"name" text NOT NULL,
	"grade_band" text NOT NULL,
	"pace" text DEFAULT 'normal',
	"encouragement" text DEFAULT 'medium',
	"goals" text[] DEFAULT ARRAY[]::text[],
	"avatar_url" text,
	"avatar_type" text DEFAULT 'default',
	"age" integer,
	"last_session_at" timestamp,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "study_guides" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"title" text NOT NULL,
	"description" text,
	"category" text NOT NULL,
	"subcategory" text,
	"grade_bands" jsonb NOT NULL,
	"subject" text,
	"content_text" text NOT NULL,
	"content_tokens" integer,
	"file_type" text DEFAULT 'guide',
	"file_path" text,
	"icon_emoji" text DEFAULT '📘',
	"sort_order" integer DEFAULT 0,
	"is_published" boolean DEFAULT true,
	"version" integer DEFAULT 1,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "subjects" (
	"id" varchar PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"description" text,
	"icon_color" text DEFAULT 'blue',
	"is_active" boolean DEFAULT true,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "trial_abuse_tracking" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"device_hash" text,
	"ip_hash" text NOT NULL,
	"user_id" varchar,
	"trial_count" integer DEFAULT 0 NOT NULL,
	"last_trial_at" timestamp,
	"week_start" date DEFAULT date_trunc('week', now())::date NOT NULL,
	"blocked" boolean DEFAULT false NOT NULL,
	"created_at" timestamp DEFAULT now() NOT NULL
);
--> statement-breakpoint
CREATE TABLE "trial_login_tokens" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"trial_session_id" varchar(36) NOT NULL,
	"token_hash" text NOT NULL,
	"expires_at" timestamp NOT NULL,
	"used_at" timestamp,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "trial_rate_limits" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"ip_hash" varchar(64) NOT NULL,
	"attempt_count" integer DEFAULT 1,
	"window_start" timestamp DEFAULT now(),
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "trial_sessions" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"email_hash" varchar(64) NOT NULL,
	"email" text,
	"verification_token" varchar(64),
	"verification_expiry" timestamp,
	"verified_at" timestamp,
	"trial_started_at" timestamp,
	"trial_ends_at" timestamp,
	"trial_grace_applied_at" timestamp,
	"used_seconds" integer DEFAULT 0,
	"consumed_seconds" integer DEFAULT 0,
	"status" varchar(20) DEFAULT 'pending',
	"device_id_hash" varchar(64),
	"ip_hash" varchar(64),
	"last_active_at" timestamp,
	"last_verification_reminder_at" timestamp,
	"verification_reminder_count" integer DEFAULT 0,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "tutor_sessions" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"student_id" varchar NOT NULL,
	"user_id" varchar NOT NULL,
	"subject" text,
	"started_at" timestamp DEFAULT now(),
	"ended_at" timestamp,
	"minutes_used" integer DEFAULT 0,
	"summary" text,
	"misconceptions" text,
	"next_steps" text,
	"context_documents" jsonb,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "usage_logs" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"session_id" varchar,
	"minutes_used" integer NOT NULL,
	"session_type" text NOT NULL,
	"timestamp" timestamp DEFAULT now() NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "user_documents" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"original_name" text NOT NULL,
	"file_name" text NOT NULL,
	"file_path" text NOT NULL,
	"file_type" text NOT NULL,
	"file_size" integer NOT NULL,
	"subject" text,
	"grade" text,
	"title" text,
	"description" text,
	"language" text DEFAULT 'en',
	"processing_status" text DEFAULT 'queued',
	"processing_error" text,
	"retry_count" integer DEFAULT 0,
	"next_retry_at" timestamp,
	"parsed_text_path" text,
	"expires_at" timestamp,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "user_progress" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"lesson_id" varchar NOT NULL,
	"status" text DEFAULT 'not_started',
	"progress_percentage" integer DEFAULT 0,
	"quiz_score" integer,
	"time_spent" integer DEFAULT 0,
	"last_accessed" timestamp DEFAULT now(),
	"completed_at" timestamp,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "user_suspensions" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"reason" text NOT NULL,
	"violation_ids" text[],
	"suspended_until" timestamp,
	"is_permanent" boolean DEFAULT false,
	"suspended_by" varchar,
	"is_active" boolean DEFAULT true,
	"lifted_at" timestamp,
	"lifted_by" varchar,
	"lift_reason" text,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
CREATE TABLE "users" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"username" text NOT NULL,
	"email" text NOT NULL,
	"password" text NOT NULL,
	"first_name" text,
	"last_name" text,
	"parent_name" text,
	"student_name" text,
	"student_age" integer,
	"grade_level" text,
	"primary_subject" text,
	"marketing_opt_in" boolean DEFAULT false,
	"marketing_opt_in_date" timestamp,
	"marketing_opt_out_date" timestamp,
	"stripe_customer_id" text,
	"stripe_subscription_id" text,
	"subscription_plan" text,
	"subscription_status" text,
	"subscription_ends_at" timestamp,
	"max_concurrent_sessions" integer DEFAULT 1,
	"max_concurrent_logins" integer DEFAULT 1,
	"subscription_minutes_used" integer DEFAULT 0,
	"subscription_minutes_limit" integer DEFAULT 60,
	"purchased_minutes_balance" integer DEFAULT 0,
	"billing_cycle_start" timestamp DEFAULT now(),
	"last_reset_at" timestamp,
	"monthly_voice_minutes" integer DEFAULT 60,
	"monthly_voice_minutes_used" integer DEFAULT 0,
	"bonus_minutes" integer DEFAULT 0,
	"monthly_reset_date" timestamp DEFAULT now(),
	"weekly_voice_minutes_used" integer DEFAULT 0,
	"weekly_reset_date" timestamp DEFAULT now(),
	"preferred_language" text,
	"voice_style" text DEFAULT 'cheerful',
	"speech_speed" numeric DEFAULT '1.0',
	"volume_level" integer DEFAULT 75,
	"is_admin" boolean DEFAULT false,
	"interface_language" varchar(10),
	"voice_language" varchar(10),
	"email_notifications" boolean,
	"marketing_emails" boolean,
	"email_summary_frequency" varchar(20) DEFAULT 'daily',
	"transcript_email" text,
	"additional_emails" text[],
	"email_verified" boolean DEFAULT false,
	"email_verification_token" text,
	"email_verification_expiry" timestamp,
	"last_verification_email_sent_at" timestamp,
	"reset_token" text,
	"reset_token_expiry" timestamp,
	"security_question_1" text,
	"security_answer_1" text,
	"security_question_2" text,
	"security_answer_2" text,
	"security_question_3" text,
	"security_answer_3" text,
	"security_questions_set" boolean DEFAULT false,
	"security_verification_token" text,
	"security_verification_expiry" timestamp,
	"is_trial_active" boolean DEFAULT false,
	"trial_minutes_limit" integer DEFAULT 30,
	"trial_minutes_used" integer DEFAULT 0,
	"trial_started_at" timestamp,
	"trial_ends_at" timestamp,
	"trial_device_hash" varchar(64),
	"trial_ip_hash" varchar(64),
	"first_login_at" timestamp,
	"is_disabled" boolean DEFAULT false,
	"disabled_at" timestamp,
	"disabled_by_admin_id" varchar,
	"deleted_at" timestamp,
	"deleted_by_admin_id" varchar,
	"deleted_reason" text,
	"canceled_at" timestamp,
	"canceled_by_admin_id" varchar,
	"created_at" timestamp DEFAULT now(),
	"updated_at" timestamp DEFAULT now(),
	CONSTRAINT "users_username_unique" UNIQUE("username"),
	CONSTRAINT "users_email_unique" UNIQUE("email")
);
--> statement-breakpoint
CREATE TABLE "verification_reminder_tracking" (
	"id" varchar PRIMARY KEY DEFAULT gen_random_uuid() NOT NULL,
	"user_id" varchar NOT NULL,
	"reminder_date" date NOT NULL,
	"created_at" timestamp DEFAULT now()
);
--> statement-breakpoint
ALTER TABLE "access_codes" ADD CONSTRAINT "access_codes_created_by_users_id_fk" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "admin_logs" ADD CONSTRAINT "admin_logs_admin_id_users_id_fk" FOREIGN KEY ("admin_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "agent_sessions" ADD CONSTRAINT "agent_sessions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "content_violations" ADD CONSTRAINT "content_violations_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "content_violations" ADD CONSTRAINT "content_violations_reviewed_by_users_id_fk" FOREIGN KEY ("reviewed_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "digest_tracking" ADD CONSTRAINT "digest_tracking_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "document_chunks" ADD CONSTRAINT "document_chunks_document_id_user_documents_id_fk" FOREIGN KEY ("document_id") REFERENCES "public"."user_documents"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "document_embeddings" ADD CONSTRAINT "document_embeddings_chunk_id_document_chunks_id_fk" FOREIGN KEY ("chunk_id") REFERENCES "public"."document_chunks"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "learning_sessions" ADD CONSTRAINT "learning_sessions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "learning_sessions" ADD CONSTRAINT "learning_sessions_lesson_id_lessons_id_fk" FOREIGN KEY ("lesson_id") REFERENCES "public"."lessons"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "lessons" ADD CONSTRAINT "lessons_subject_id_subjects_id_fk" FOREIGN KEY ("subject_id") REFERENCES "public"."subjects"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "marketing_campaigns" ADD CONSTRAINT "marketing_campaigns_admin_id_users_id_fk" FOREIGN KEY ("admin_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "memory_jobs" ADD CONSTRAINT "memory_jobs_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "memory_jobs" ADD CONSTRAINT "memory_jobs_student_id_students_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "memory_jobs" ADD CONSTRAINT "memory_jobs_session_id_realtime_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."realtime_sessions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "minute_purchases" ADD CONSTRAINT "minute_purchases_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "notification_preferences" ADD CONSTRAINT "notification_preferences_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "quiz_attempts" ADD CONSTRAINT "quiz_attempts_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "quiz_attempts" ADD CONSTRAINT "quiz_attempts_lesson_id_lessons_id_fk" FOREIGN KEY ("lesson_id") REFERENCES "public"."lessons"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "quiz_attempts" ADD CONSTRAINT "quiz_attempts_session_id_learning_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."learning_sessions"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "realtime_sessions" ADD CONSTRAINT "realtime_sessions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "realtime_sessions" ADD CONSTRAINT "realtime_sessions_student_id_students_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "safety_incidents" ADD CONSTRAINT "safety_incidents_session_id_realtime_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."realtime_sessions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "safety_incidents" ADD CONSTRAINT "safety_incidents_student_id_students_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "safety_incidents" ADD CONSTRAINT "safety_incidents_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "session_summaries" ADD CONSTRAINT "session_summaries_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "session_summaries" ADD CONSTRAINT "session_summaries_student_id_students_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "session_summaries" ADD CONSTRAINT "session_summaries_session_id_realtime_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."realtime_sessions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_calendar_events" ADD CONSTRAINT "student_calendar_events_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_calendar_events" ADD CONSTRAINT "student_calendar_events_course_id_student_courses_id_fk" FOREIGN KEY ("course_id") REFERENCES "public"."student_courses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_courses" ADD CONSTRAINT "student_courses_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_doc_pins" ADD CONSTRAINT "student_doc_pins_student_id_students_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_doc_pins" ADD CONSTRAINT "student_doc_pins_doc_id_user_documents_id_fk" FOREIGN KEY ("doc_id") REFERENCES "public"."user_documents"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_engagement_scores" ADD CONSTRAINT "student_engagement_scores_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_engagement_scores" ADD CONSTRAINT "student_engagement_scores_course_id_student_courses_id_fk" FOREIGN KEY ("course_id") REFERENCES "public"."student_courses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_lesson_progress" ADD CONSTRAINT "student_lesson_progress_student_id_students_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_lesson_progress" ADD CONSTRAINT "student_lesson_progress_lesson_id_practice_lessons_id_fk" FOREIGN KEY ("lesson_id") REFERENCES "public"."practice_lessons"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_parent_shares" ADD CONSTRAINT "student_parent_shares_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_reminders" ADD CONSTRAINT "student_reminders_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_reminders" ADD CONSTRAINT "student_reminders_event_id_student_calendar_events_id_fk" FOREIGN KEY ("event_id") REFERENCES "public"."student_calendar_events"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_reminders" ADD CONSTRAINT "student_reminders_task_id_student_tasks_id_fk" FOREIGN KEY ("task_id") REFERENCES "public"."student_tasks"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_tasks" ADD CONSTRAINT "student_tasks_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_tasks" ADD CONSTRAINT "student_tasks_course_id_student_courses_id_fk" FOREIGN KEY ("course_id") REFERENCES "public"."student_courses"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "student_tasks" ADD CONSTRAINT "student_tasks_event_id_student_calendar_events_id_fk" FOREIGN KEY ("event_id") REFERENCES "public"."student_calendar_events"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "students" ADD CONSTRAINT "students_owner_user_id_users_id_fk" FOREIGN KEY ("owner_user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "trial_abuse_tracking" ADD CONSTRAINT "trial_abuse_tracking_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE set null ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "trial_login_tokens" ADD CONSTRAINT "trial_login_tokens_trial_session_id_trial_sessions_id_fk" FOREIGN KEY ("trial_session_id") REFERENCES "public"."trial_sessions"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tutor_sessions" ADD CONSTRAINT "tutor_sessions_student_id_students_id_fk" FOREIGN KEY ("student_id") REFERENCES "public"."students"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "tutor_sessions" ADD CONSTRAINT "tutor_sessions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "usage_logs" ADD CONSTRAINT "usage_logs_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "usage_logs" ADD CONSTRAINT "usage_logs_session_id_learning_sessions_id_fk" FOREIGN KEY ("session_id") REFERENCES "public"."learning_sessions"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_documents" ADD CONSTRAINT "user_documents_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_progress" ADD CONSTRAINT "user_progress_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_progress" ADD CONSTRAINT "user_progress_lesson_id_lessons_id_fk" FOREIGN KEY ("lesson_id") REFERENCES "public"."lessons"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_suspensions" ADD CONSTRAINT "user_suspensions_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_suspensions" ADD CONSTRAINT "user_suspensions_suspended_by_users_id_fk" FOREIGN KEY ("suspended_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "user_suspensions" ADD CONSTRAINT "user_suspensions_lifted_by_users_id_fk" FOREIGN KEY ("lifted_by") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_disabled_by_admin_id_users_id_fk" FOREIGN KEY ("disabled_by_admin_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_deleted_by_admin_id_users_id_fk" FOREIGN KEY ("deleted_by_admin_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "users" ADD CONSTRAINT "users_canceled_by_admin_id_users_id_fk" FOREIGN KEY ("canceled_by_admin_id") REFERENCES "public"."users"("id") ON DELETE no action ON UPDATE no action;--> statement-breakpoint
ALTER TABLE "verification_reminder_tracking" ADD CONSTRAINT "verification_reminder_tracking_user_id_users_id_fk" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id") ON DELETE cascade ON UPDATE no action;--> statement-breakpoint
CREATE INDEX "idx_access_codes_code" ON "access_codes" USING btree ("code");--> statement-breakpoint
CREATE INDEX "idx_access_codes_active" ON "access_codes" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "idx_agent_sessions_user" ON "agent_sessions" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_agent_sessions_agent" ON "agent_sessions" USING btree ("agent_id");--> statement-breakpoint
CREATE INDEX "idx_agent_sessions_expires" ON "agent_sessions" USING btree ("expires_at");--> statement-breakpoint
CREATE INDEX "idx_violations_user" ON "content_violations" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_violations_status" ON "content_violations" USING btree ("review_status");--> statement-breakpoint
CREATE INDEX "idx_violations_created" ON "content_violations" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "idx_digest_tracking_user" ON "digest_tracking" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_digest_tracking_date" ON "digest_tracking" USING btree ("digest_date");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_digest_tracking_unique" ON "digest_tracking" USING btree ("user_id","digest_type","digest_date");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_chunks_document_index" ON "document_chunks" USING btree ("document_id","chunk_index");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_embeddings_chunk_unique" ON "document_embeddings" USING btree ("chunk_id");--> statement-breakpoint
CREATE INDEX "idx_embeddings_hnsw" ON "document_embeddings" USING hnsw ("embedding" vector_cosine_ops);--> statement-breakpoint
CREATE INDEX "idx_campaigns_admin" ON "marketing_campaigns" USING btree ("admin_id");--> statement-breakpoint
CREATE INDEX "idx_campaigns_exported" ON "marketing_campaigns" USING btree ("exported_at");--> statement-breakpoint
CREATE INDEX "idx_memory_jobs_status_runafter" ON "memory_jobs" USING btree ("status","run_after","created_at");--> statement-breakpoint
CREATE INDEX "idx_minute_purchases_user" ON "minute_purchases" USING btree ("user_id","status");--> statement-breakpoint
CREATE INDEX "idx_notif_prefs_user" ON "notification_preferences" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_notif_prefs_child" ON "notification_preferences" USING btree ("child_id");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_notif_prefs_unsub" ON "notification_preferences" USING btree ("unsubscribe_token");--> statement-breakpoint
CREATE INDEX "idx_page_views_created_at" ON "page_views" USING btree ("created_at");--> statement-breakpoint
CREATE INDEX "idx_page_views_page_path" ON "page_views" USING btree ("page_path");--> statement-breakpoint
CREATE INDEX "idx_lessons_grade" ON "practice_lessons" USING btree ("grade");--> statement-breakpoint
CREATE INDEX "idx_lessons_subject" ON "practice_lessons" USING btree ("subject");--> statement-breakpoint
CREATE INDEX "idx_lessons_topic" ON "practice_lessons" USING btree ("topic");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_lessons_unique" ON "practice_lessons" USING btree ("grade","subject","topic","order_index");--> statement-breakpoint
CREATE INDEX "idx_realtime_sessions_user" ON "realtime_sessions" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_realtime_sessions_student" ON "realtime_sessions" USING btree ("student_id");--> statement-breakpoint
CREATE INDEX "idx_realtime_sessions_status" ON "realtime_sessions" USING btree ("status");--> statement-breakpoint
CREATE INDEX "idx_sessions_user_started" ON "realtime_sessions" USING btree ("user_id","started_at");--> statement-breakpoint
CREATE INDEX "IDX_registration_token_expires" ON "registration_tokens" USING btree ("expires_at");--> statement-breakpoint
CREATE INDEX "IDX_registration_token_email" ON "registration_tokens" USING btree ("email");--> statement-breakpoint
CREATE INDEX "idx_safety_incidents_user" ON "safety_incidents" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_safety_incidents_session" ON "safety_incidents" USING btree ("session_id");--> statement-breakpoint
CREATE INDEX "idx_safety_incidents_type" ON "safety_incidents" USING btree ("flag_type");--> statement-breakpoint
CREATE INDEX "idx_safety_incidents_severity" ON "safety_incidents" USING btree ("severity");--> statement-breakpoint
CREATE INDEX "idx_session_summaries_user_date" ON "session_summaries" USING btree ("user_id","created_at");--> statement-breakpoint
CREATE INDEX "idx_session_summaries_student_date" ON "session_summaries" USING btree ("student_id","created_at");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_session_summaries_session" ON "session_summaries" USING btree ("session_id");--> statement-breakpoint
CREATE INDEX "IDX_session_expire" ON "sessions" USING btree ("expire");--> statement-breakpoint
CREATE INDEX "idx_calendar_events_user" ON "student_calendar_events" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_calendar_events_course" ON "student_calendar_events" USING btree ("course_id");--> statement-breakpoint
CREATE INDEX "idx_calendar_events_date" ON "student_calendar_events" USING btree ("start_date");--> statement-breakpoint
CREATE INDEX "idx_student_courses_user" ON "student_courses" USING btree ("user_id");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_student_doc_unique" ON "student_doc_pins" USING btree ("student_id","doc_id");--> statement-breakpoint
CREATE INDEX "idx_student_pins" ON "student_doc_pins" USING btree ("student_id");--> statement-breakpoint
CREATE INDEX "idx_engagement_scores_user" ON "student_engagement_scores" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_engagement_scores_week" ON "student_engagement_scores" USING btree ("week_start");--> statement-breakpoint
CREATE INDEX "idx_progress_student" ON "student_lesson_progress" USING btree ("student_id");--> statement-breakpoint
CREATE INDEX "idx_progress_status" ON "student_lesson_progress" USING btree ("status");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_progress_unique" ON "student_lesson_progress" USING btree ("student_id","lesson_id");--> statement-breakpoint
CREATE INDEX "idx_parent_shares_user" ON "student_parent_shares" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_student_reminders_user" ON "student_reminders" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_student_reminders_date" ON "student_reminders" USING btree ("reminder_date");--> statement-breakpoint
CREATE INDEX "idx_student_tasks_user" ON "student_tasks" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_student_tasks_course" ON "student_tasks" USING btree ("course_id");--> statement-breakpoint
CREATE INDEX "idx_student_tasks_event" ON "student_tasks" USING btree ("event_id");--> statement-breakpoint
CREATE INDEX "idx_student_tasks_due" ON "student_tasks" USING btree ("due_date");--> statement-breakpoint
CREATE INDEX "idx_students_owner" ON "students" USING btree ("owner_user_id");--> statement-breakpoint
CREATE INDEX "idx_study_guides_category" ON "study_guides" USING btree ("category");--> statement-breakpoint
CREATE INDEX "idx_study_guides_published" ON "study_guides" USING btree ("is_published");--> statement-breakpoint
CREATE INDEX "idx_trial_abuse_device" ON "trial_abuse_tracking" USING btree ("device_hash");--> statement-breakpoint
CREATE INDEX "idx_trial_abuse_ip" ON "trial_abuse_tracking" USING btree ("ip_hash");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_trial_abuse_ip_week" ON "trial_abuse_tracking" USING btree ("ip_hash","week_start");--> statement-breakpoint
CREATE INDEX "idx_trial_abuse_ip_recent" ON "trial_abuse_tracking" USING btree ("ip_hash","last_trial_at");--> statement-breakpoint
CREATE INDEX "idx_trial_abuse_week_start" ON "trial_abuse_tracking" USING btree ("week_start");--> statement-breakpoint
CREATE INDEX "idx_trial_abuse_user_id" ON "trial_abuse_tracking" USING btree ("user_id");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_trial_login_token_hash" ON "trial_login_tokens" USING btree ("token_hash");--> statement-breakpoint
CREATE INDEX "idx_trial_login_session" ON "trial_login_tokens" USING btree ("trial_session_id");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_rate_limit_ip" ON "trial_rate_limits" USING btree ("ip_hash");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_trial_email_hash" ON "trial_sessions" USING btree ("email_hash");--> statement-breakpoint
CREATE INDEX "idx_trial_device_hash" ON "trial_sessions" USING btree ("device_id_hash");--> statement-breakpoint
CREATE INDEX "idx_trial_status" ON "trial_sessions" USING btree ("status");--> statement-breakpoint
CREATE INDEX "idx_trial_verification_token" ON "trial_sessions" USING btree ("verification_token");--> statement-breakpoint
CREATE INDEX "idx_tutor_sessions_student" ON "tutor_sessions" USING btree ("student_id");--> statement-breakpoint
CREATE INDEX "idx_tutor_sessions_user" ON "tutor_sessions" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_tutor_sessions_latest" ON "tutor_sessions" USING btree ("student_id","started_at");--> statement-breakpoint
CREATE INDEX "idx_user_docs_status" ON "user_documents" USING btree ("processing_status");--> statement-breakpoint
CREATE INDEX "idx_user_docs_retry" ON "user_documents" USING btree ("next_retry_at");--> statement-breakpoint
CREATE INDEX "idx_user_docs_expires" ON "user_documents" USING btree ("expires_at");--> statement-breakpoint
CREATE INDEX "idx_suspensions_user" ON "user_suspensions" USING btree ("user_id");--> statement-breakpoint
CREATE INDEX "idx_suspensions_active" ON "user_suspensions" USING btree ("is_active");--> statement-breakpoint
CREATE INDEX "idx_verification_reminder_user" ON "verification_reminder_tracking" USING btree ("user_id");--> statement-breakpoint
CREATE UNIQUE INDEX "idx_verification_reminder_unique" ON "verification_reminder_tracking" USING btree ("user_id","reminder_date");

-- ─────────────────────────────────────────────────────────────────────────────
-- Post-bootstrap fixups (Notre Dame deployment — per Section 8 of the build spec)
--
-- These statements are required after the drizzle-generated DDL because:
--   (a) drizzle-kit generate does not always pick up the matched_terms column
--       on content_violations (standing learning from the State and USC builds).
--   (b) trial_abuse_tracking.ip_hash must be nullable in production (standing
--       learning from prior builds — drizzle generates it as NOT NULL).
--   (c) The pgvector extension is required for document_embeddings; it must be
--       enabled before the migration runs. Pollis runs `CREATE EXTENSION IF NOT
--       EXISTS vector;` in Beekeeper as a separate pre-step.
-- ─────────────────────────────────────────────────────────────────────────────

-- (a) content_violations.matched_terms
ALTER TABLE content_violations
  ADD COLUMN IF NOT EXISTS matched_terms text[];

-- (b) trial_abuse_tracking.ip_hash nullable
ALTER TABLE trial_abuse_tracking
  ALTER COLUMN ip_hash DROP NOT NULL;
