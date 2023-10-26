Return-Path: <linux-block-owner@vger.kernel.org>
X-Original-To: lists+linux-block@lfdr.de
Delivered-To: lists+linux-block@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE3687D8A95
	for <lists+linux-block@lfdr.de>; Thu, 26 Oct 2023 23:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjJZVma (ORCPT <rfc822;lists+linux-block@lfdr.de>);
        Thu, 26 Oct 2023 17:42:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjJZVma (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2023 17:42:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62B110E
        for <linux-block@vger.kernel.org>; Thu, 26 Oct 2023 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698356499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=chfx64uLJD/sf1u+eg1ZQv38Q/wef9blrTzhCFG3FOI=;
        b=XxOPY9JbARIg26DtZvJwj6rgPZvpT3WBXF3uQrFudcmKaQEgag+epMQcWQhabpsQ14gs98
        TyoNb9QGIpWlrFFdqhyMSxs9s+xsIyOVYOtMkKPmguuGI2j9rdQE5h1xDR/vea8+3PefR5
        VGtNM0zg4K5vns8uhTh7pcnzS/W2VQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-eNSyWPJAOiimmfsV-KT7dQ-1; Thu, 26 Oct 2023 17:41:38 -0400
X-MC-Unique: eNSyWPJAOiimmfsV-KT7dQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25CE2185A784;
        Thu, 26 Oct 2023 21:41:38 +0000 (UTC)
Received: from pbitcolo-build-10.permabit.com (pbitcolo-build-10.permabit.lab.eng.bos.redhat.com [10.19.117.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16D0A167AB;
        Thu, 26 Oct 2023 21:41:38 +0000 (UTC)
Received: by pbitcolo-build-10.permabit.com (Postfix, from userid 1138)
        id CABB03003D; Thu, 26 Oct 2023 17:41:37 -0400 (EDT)
From:   Matthew Sakai <msakai@redhat.com>
To:     dm-devel@lists.linux.dev, linux-block@vger.kernel.org
Cc:     Matthew Sakai <msakai@redhat.com>
Subject: [PATCH v4 06/39] dm vdo: add thread and synchronization utilities
Date:   Thu, 26 Oct 2023 17:41:03 -0400
Message-Id: <20231026214136.1067410-7-msakai@redhat.com>
In-Reply-To: <20231026214136.1067410-1-msakai@redhat.com>
References: <20231026214136.1067410-1-msakai@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch adds utilities for managing and using named threads, as well as
several locking and synchronization utilities. These utilities help dm-vdo
minimize thread transitions and manage interactions between threads.

Co-developed-by: J. corwin Coburn <corwin@hurlbutnet.net>
Signed-off-by: J. corwin Coburn <corwin@hurlbutnet.net>
Co-developed-by: Michael Sclafani <vdo-devel@redhat.com>
Signed-off-by: Michael Sclafani <vdo-devel@redhat.com>
Co-developed-by: Thomas Jaskiewicz <tom@jaskiewicz.us>
Signed-off-by: Thomas Jaskiewicz <tom@jaskiewicz.us>
Co-developed-by: Bruce Johnston <bjohnsto@redhat.com>
Signed-off-by: Bruce Johnston <bjohnsto@redhat.com>
Co-developed-by: Ken Raeburn <raeburn@redhat.com>
Signed-off-by: Ken Raeburn <raeburn@redhat.com>
Signed-off-by: Matthew Sakai <msakai@redhat.com>
---
 drivers/md/dm-vdo/thread-cond-var.c |  46 +++++++
 drivers/md/dm-vdo/thread-device.c   |  35 ++++++
 drivers/md/dm-vdo/thread-device.h   |  19 +++
 drivers/md/dm-vdo/thread-registry.c |  93 ++++++++++++++
 drivers/md/dm-vdo/thread-registry.h |  33 +++++
 drivers/md/dm-vdo/uds-threads.c     | 186 ++++++++++++++++++++++++++++
 drivers/md/dm-vdo/uds-threads.h     | 115 +++++++++++++++++
 7 files changed, 527 insertions(+)
 create mode 100644 drivers/md/dm-vdo/thread-cond-var.c
 create mode 100644 drivers/md/dm-vdo/thread-device.c
 create mode 100644 drivers/md/dm-vdo/thread-device.h
 create mode 100644 drivers/md/dm-vdo/thread-registry.c
 create mode 100644 drivers/md/dm-vdo/thread-registry.h
 create mode 100644 drivers/md/dm-vdo/uds-threads.c
 create mode 100644 drivers/md/dm-vdo/uds-threads.h

diff --git a/drivers/md/dm-vdo/thread-cond-var.c b/drivers/md/dm-vdo/thread-cond-var.c
new file mode 100644
index 000000000000..ed7f0b79ca0a
--- /dev/null
+++ b/drivers/md/dm-vdo/thread-cond-var.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#include <linux/jiffies.h>
+#include <linux/minmax.h>
+
+#include "errors.h"
+#include "time-utils.h"
+#include "uds-threads.h"
+
+int uds_init_cond(struct cond_var *cv)
+{
+	init_waitqueue_head(&cv->wait_queue);
+	return UDS_SUCCESS;
+}
+
+int uds_signal_cond(struct cond_var *cv)
+{
+	wake_up(&cv->wait_queue);
+	return UDS_SUCCESS;
+}
+
+int uds_broadcast_cond(struct cond_var *cv)
+{
+	wake_up_all(&cv->wait_queue);
+	return UDS_SUCCESS;
+}
+
+int uds_wait_cond(struct cond_var *cv, struct mutex *mutex)
+{
+	DEFINE_WAIT(__wait);
+
+	prepare_to_wait(&cv->wait_queue, &__wait, TASK_IDLE);
+	uds_unlock_mutex(mutex);
+	schedule();
+	finish_wait(&cv->wait_queue, &__wait);
+	uds_lock_mutex(mutex);
+	return UDS_SUCCESS;
+}
+
+int uds_destroy_cond(struct cond_var *cv)
+{
+	return UDS_SUCCESS;
+}
diff --git a/drivers/md/dm-vdo/thread-device.c b/drivers/md/dm-vdo/thread-device.c
new file mode 100644
index 000000000000..897d8490c3af
--- /dev/null
+++ b/drivers/md/dm-vdo/thread-device.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#include "thread-device.h"
+
+#include "thread-registry.h"
+
+/* A registry of threads associated with device id numbers. */
+static struct thread_registry device_id_thread_registry;
+
+/* Any registered thread must be unregistered. */
+void uds_register_thread_device_id(struct registered_thread *new_thread, unsigned int *id_ptr)
+{
+	uds_register_thread(&device_id_thread_registry, new_thread, id_ptr);
+}
+
+void uds_unregister_thread_device_id(void)
+{
+	uds_unregister_thread(&device_id_thread_registry);
+}
+
+int uds_get_thread_device_id(void)
+{
+	const unsigned int *pointer;
+
+	pointer = uds_lookup_thread(&device_id_thread_registry);
+	return (pointer != NULL) ? *pointer : -1;
+}
+
+void uds_initialize_thread_device_registry(void)
+{
+	uds_initialize_thread_registry(&device_id_thread_registry);
+}
diff --git a/drivers/md/dm-vdo/thread-device.h b/drivers/md/dm-vdo/thread-device.h
new file mode 100644
index 000000000000..c1c189f0d248
--- /dev/null
+++ b/drivers/md/dm-vdo/thread-device.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#ifndef UDS_THREAD_DEVICE_H
+#define UDS_THREAD_DEVICE_H
+
+#include "thread-registry.h"
+
+void uds_register_thread_device_id(struct registered_thread *new_thread, unsigned int *id_ptr);
+
+void uds_unregister_thread_device_id(void);
+
+int uds_get_thread_device_id(void);
+
+void uds_initialize_thread_device_registry(void);
+
+#endif /* UDS_THREAD_DEVICE_H */
diff --git a/drivers/md/dm-vdo/thread-registry.c b/drivers/md/dm-vdo/thread-registry.c
new file mode 100644
index 000000000000..6e76cf2a93b6
--- /dev/null
+++ b/drivers/md/dm-vdo/thread-registry.c
@@ -0,0 +1,93 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#include "thread-registry.h"
+
+#include <linux/rculist.h>
+
+#include "permassert.h"
+
+/*
+ * We need to be careful when using other facilities that may use thread registry functions in
+ * their normal operation. For example, we do not want to invoke the logger while holding a lock.
+ */
+
+void uds_initialize_thread_registry(struct thread_registry *registry)
+{
+	INIT_LIST_HEAD(&registry->links);
+	spin_lock_init(&registry->lock);
+}
+
+/* Register the current thread and associate it with a data pointer. */
+void uds_register_thread(struct thread_registry *registry,
+			 struct registered_thread *new_thread,
+			 const void *pointer)
+{
+	struct registered_thread *thread;
+	bool found_it = false;
+
+	INIT_LIST_HEAD(&new_thread->links);
+	new_thread->pointer = pointer;
+	new_thread->task = current;
+
+	spin_lock(&registry->lock);
+	list_for_each_entry(thread, &registry->links, links) {
+		if (thread->task == current) {
+			/* There should be no existing entry. */
+			list_del_rcu(&thread->links);
+			found_it = true;
+			break;
+		}
+	}
+	list_add_tail_rcu(&new_thread->links, &registry->links);
+	spin_unlock(&registry->lock);
+
+	ASSERT_LOG_ONLY(!found_it, "new thread not already in registry");
+	if (found_it) {
+		/* Ensure no RCU iterators see it before re-initializing. */
+		synchronize_rcu();
+		INIT_LIST_HEAD(&thread->links);
+	}
+}
+
+void uds_unregister_thread(struct thread_registry *registry)
+{
+	struct registered_thread *thread;
+	bool found_it = false;
+
+	spin_lock(&registry->lock);
+	list_for_each_entry(thread, &registry->links, links) {
+		if (thread->task == current) {
+			list_del_rcu(&thread->links);
+			found_it = true;
+			break;
+		}
+	}
+	spin_unlock(&registry->lock);
+
+	ASSERT_LOG_ONLY(found_it, "thread found in registry");
+	if (found_it) {
+		/* Ensure no RCU iterators see it before re-initializing. */
+		synchronize_rcu();
+		INIT_LIST_HEAD(&thread->links);
+	}
+}
+
+const void *uds_lookup_thread(struct thread_registry *registry)
+{
+	struct registered_thread *thread;
+	const void *result = NULL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(thread, &registry->links, links) {
+		if (thread->task == current) {
+			result = thread->pointer;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+	return result;
+}
diff --git a/drivers/md/dm-vdo/thread-registry.h b/drivers/md/dm-vdo/thread-registry.h
new file mode 100644
index 000000000000..05d82a8211fe
--- /dev/null
+++ b/drivers/md/dm-vdo/thread-registry.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#ifndef UDS_THREAD_REGISTRY_H
+#define UDS_THREAD_REGISTRY_H
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+struct thread_registry {
+	struct list_head links;
+	spinlock_t lock;
+};
+
+struct registered_thread {
+	struct list_head links;
+	const void *pointer;
+	struct task_struct *task;
+};
+
+void uds_initialize_thread_registry(struct thread_registry *registry);
+
+void uds_register_thread(struct thread_registry *registry,
+			 struct registered_thread *new_thread,
+			 const void *pointer);
+
+void uds_unregister_thread(struct thread_registry *registry);
+
+const void *uds_lookup_thread(struct thread_registry *registry);
+
+#endif /* UDS_THREAD_REGISTRY_H */
diff --git a/drivers/md/dm-vdo/uds-threads.c b/drivers/md/dm-vdo/uds-threads.c
new file mode 100644
index 000000000000..17737246d28c
--- /dev/null
+++ b/drivers/md/dm-vdo/uds-threads.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#include "uds-threads.h"
+
+#include <linux/completion.h>
+#include <linux/err.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+
+#include "errors.h"
+#include "logger.h"
+#include "memory-alloc.h"
+
+static struct hlist_head thread_list;
+static struct mutex thread_mutex;
+static atomic_t thread_once = ATOMIC_INIT(0);
+
+struct thread {
+	void (*thread_function)(void *thread_data);
+	void *thread_data;
+	struct hlist_node thread_links;
+	struct task_struct *thread_task;
+	struct completion thread_done;
+};
+
+enum {
+	ONCE_NOT_DONE = 0,
+	ONCE_IN_PROGRESS = 1,
+	ONCE_COMPLETE = 2,
+};
+
+/* Run a function once only, and record that fact in the atomic value. */
+void uds_perform_once(atomic_t *once, void (*function)(void))
+{
+	for (;;) {
+		switch (atomic_cmpxchg(once, ONCE_NOT_DONE, ONCE_IN_PROGRESS)) {
+		case ONCE_NOT_DONE:
+			function();
+			atomic_set_release(once, ONCE_COMPLETE);
+			return;
+		case ONCE_IN_PROGRESS:
+			cond_resched();
+			break;
+		case ONCE_COMPLETE:
+			return;
+		default:
+			return;
+		}
+	}
+}
+
+static void thread_init(void)
+{
+	mutex_init(&thread_mutex);
+}
+
+static int thread_starter(void *arg)
+{
+	struct registered_thread allocating_thread;
+	struct thread *thread = arg;
+
+	thread->thread_task = current;
+	uds_perform_once(&thread_once, thread_init);
+	mutex_lock(&thread_mutex);
+	hlist_add_head(&thread->thread_links, &thread_list);
+	mutex_unlock(&thread_mutex);
+	uds_register_allocating_thread(&allocating_thread, NULL);
+	thread->thread_function(thread->thread_data);
+	uds_unregister_allocating_thread();
+	complete(&thread->thread_done);
+	return 0;
+}
+
+int uds_create_thread(void (*thread_function)(void *),
+		      void *thread_data,
+		      const char *name,
+		      struct thread **new_thread)
+{
+	char *name_colon = strchr(name, ':');
+	char *my_name_colon = strchr(current->comm, ':');
+	struct task_struct *task;
+	struct thread *thread;
+	int result;
+
+	result = UDS_ALLOCATE(1, struct thread, __func__, &thread);
+	if (result != UDS_SUCCESS) {
+		uds_log_warning("Error allocating memory for %s", name);
+		return result;
+	}
+
+	thread->thread_function = thread_function;
+	thread->thread_data = thread_data;
+	init_completion(&thread->thread_done);
+	/*
+	 * Start the thread, with an appropriate thread name.
+	 *
+	 * If the name supplied contains a colon character, use that name. This causes uds module
+	 * threads to have names like "uds:callbackW" and the main test runner thread to be named
+	 * "zub:runtest".
+	 *
+	 * Otherwise if the current thread has a name containing a colon character, prefix the name
+	 * supplied with the name of the current thread up to (and including) the colon character.
+	 * Thus when the "kvdo0:dedupeQ" thread opens an index session, all the threads associated
+	 * with that index will have names like "kvdo0:foo".
+	 *
+	 * Otherwise just use the name supplied. This should be a rare occurrence.
+	 */
+	if ((name_colon == NULL) && (my_name_colon != NULL))
+		task = kthread_run(thread_starter,
+				   thread,
+				   "%.*s:%s",
+				   (int) (my_name_colon - current->comm),
+				   current->comm,
+				   name);
+	else
+		task = kthread_run(thread_starter, thread, "%s", name);
+
+	if (IS_ERR(task)) {
+		UDS_FREE(thread);
+		return PTR_ERR(task);
+	}
+
+	*new_thread = thread;
+	return UDS_SUCCESS;
+}
+
+int uds_join_threads(struct thread *thread)
+{
+	while (wait_for_completion_interruptible(&thread->thread_done) != 0)
+		/* empty loop */
+		;
+
+	mutex_lock(&thread_mutex);
+	hlist_del(&thread->thread_links);
+	mutex_unlock(&thread_mutex);
+	UDS_FREE(thread);
+	return UDS_SUCCESS;
+}
+
+int uds_initialize_barrier(struct barrier *barrier, unsigned int thread_count)
+{
+	int result;
+
+	result = uds_initialize_semaphore(&barrier->mutex, 1);
+	if (result != UDS_SUCCESS)
+		return result;
+
+	barrier->arrived = 0;
+	barrier->thread_count = thread_count;
+	return uds_initialize_semaphore(&barrier->wait, 0);
+}
+
+int uds_destroy_barrier(struct barrier *barrier)
+{
+	int result;
+
+	result = uds_destroy_semaphore(&barrier->mutex);
+	if (result != UDS_SUCCESS)
+		return result;
+	return uds_destroy_semaphore(&barrier->wait);
+}
+
+int uds_enter_barrier(struct barrier *barrier)
+{
+	bool last_thread;
+
+	uds_acquire_semaphore(&barrier->mutex);
+	last_thread = (++barrier->arrived == barrier->thread_count);
+	if (last_thread) {
+		int i;
+
+		for (i = 1; i < barrier->thread_count; i++)
+			uds_release_semaphore(&barrier->wait);
+
+		barrier->arrived = 0;
+		uds_release_semaphore(&barrier->mutex);
+	} else {
+		uds_release_semaphore(&barrier->mutex);
+		uds_acquire_semaphore(&barrier->wait);
+	}
+
+	return UDS_SUCCESS;
+}
diff --git a/drivers/md/dm-vdo/uds-threads.h b/drivers/md/dm-vdo/uds-threads.h
new file mode 100644
index 000000000000..9b65bf65c595
--- /dev/null
+++ b/drivers/md/dm-vdo/uds-threads.h
@@ -0,0 +1,115 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright 2023 Red Hat
+ */
+
+#ifndef UDS_THREADS_H
+#define UDS_THREADS_H
+
+#include <linux/atomic.h>
+#include <linux/delay.h>
+#include <linux/jiffies.h>
+#include <linux/mutex.h>
+#include <linux/semaphore.h>
+#include <linux/wait.h>
+
+#include "errors.h"
+#include "time-utils.h"
+
+/* Thread and synchronization utilities for UDS */
+
+struct cond_var {
+	wait_queue_head_t wait_queue;
+};
+
+struct thread;
+
+struct barrier {
+	/* Mutex for this barrier object */
+	struct semaphore mutex;
+	/* Semaphore for threads waiting at the barrier */
+	struct semaphore wait;
+	/* Number of threads which have arrived */
+	int arrived;
+	/* Total number of threads using this barrier */
+	int thread_count;
+};
+
+int __must_check uds_create_thread(void (*thread_function)(void *),
+				   void *thread_data,
+				   const char *name,
+				   struct thread **new_thread);
+
+void uds_perform_once(atomic_t *once_state, void (*function) (void));
+
+int uds_join_threads(struct thread *thread);
+
+int __must_check uds_initialize_barrier(struct barrier *barrier, unsigned int thread_count);
+int uds_destroy_barrier(struct barrier *barrier);
+int uds_enter_barrier(struct barrier *barrier);
+
+int __must_check uds_init_cond(struct cond_var *cond);
+int uds_signal_cond(struct cond_var *cond);
+int uds_broadcast_cond(struct cond_var *cond);
+int uds_wait_cond(struct cond_var *cond, struct mutex *mutex);
+int uds_destroy_cond(struct cond_var *cond);
+
+static inline int __must_check uds_init_mutex(struct mutex *mutex)
+{
+	mutex_init(mutex);
+	return UDS_SUCCESS;
+}
+
+static inline int uds_destroy_mutex(struct mutex *mutex)
+{
+	return UDS_SUCCESS;
+}
+
+static inline void uds_lock_mutex(struct mutex *mutex)
+{
+	mutex_lock(mutex);
+}
+
+static inline void uds_unlock_mutex(struct mutex *mutex)
+{
+	mutex_unlock(mutex);
+}
+
+static inline int __must_check
+uds_initialize_semaphore(struct semaphore *semaphore, unsigned int value)
+{
+	sema_init(semaphore, value);
+	return UDS_SUCCESS;
+}
+
+static inline int uds_destroy_semaphore(struct semaphore *semaphore)
+{
+	return UDS_SUCCESS;
+}
+
+static inline void uds_acquire_semaphore(struct semaphore *semaphore)
+{
+	/*
+	 * Do not use down(semaphore). Instead use down_interruptible so that
+	 * we do not get 120 second stall messages in kern.log.
+	 */
+	while (down_interruptible(semaphore) != 0)
+		/*
+		 * If we're called from a user-mode process (e.g., "dmsetup
+		 * remove") while waiting for an operation that may take a
+		 * while (e.g., UDS index save), and a signal is sent (SIGINT,
+		 * SIGUSR2), then down_interruptible will not block. If that
+		 * happens, sleep briefly to avoid keeping the CPU locked up in
+		 * this loop. We could just call cond_resched, but then we'd
+		 * still keep consuming CPU time slices and swamp other threads
+		 * trying to do computational work. [VDO-4980]
+		 */
+		fsleep(1000);
+}
+
+static inline void uds_release_semaphore(struct semaphore *semaphore)
+{
+	up(semaphore);
+}
+
+#endif /* UDS_THREADS_H */
-- 
2.40.0

